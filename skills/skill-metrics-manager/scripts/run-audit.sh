#!/bin/bash

# 1. Run the core metrics collection
echo "Running metrics collection..."
"$(dirname "$0")/collect-metrics.sh"

METRICS_FILE=".ops/audit_logs/metrics.json"
HISTORY_DIR=".ops/audit_logs/history"

if [ ! -f "$METRICS_FILE" ]; then
  echo "Error: Metrics file was not generated."
  exit 1
fi

# 2. Archive with timestamp
mkdir -p "$HISTORY_DIR"
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
HISTORY_FILE="$HISTORY_DIR/metrics_$TIMESTAMP.json"

cp "$METRICS_FILE" "$HISTORY_FILE"

echo "Metrics archived to: $HISTORY_FILE"

# 3. Check Quality Gates if --check is provided
if [[ "$*" == *"--check"* ]]; then
  python3 "$(dirname "$0")/check-gates.py"
  GATE_EXIT_CODE=$?
else
  GATE_EXIT_CODE=0
fi

# 4. Display summary (requires jq)
if command -v jq >/dev/null 2>&1; then
  echo ""
  echo "--- Current Status ---"
  jq .metrics "$METRICS_FILE"
else
  echo ""
  echo "Tip: Install 'jq' for better visualization."
fi

exit $GATE_EXIT_CODE
