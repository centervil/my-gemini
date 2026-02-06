#!/bin/bash

# Usage: ./create-collector.sh [filename_without_extension]
# Example: ./create-collector.sh check_todos

NAME=$1
if [ -z "$NAME" ]; then
  echo "Error: Filename argument is required."
  echo "Usage: $0 [filename_without_extension]"
  exit 1
fi

TARGET_DIR=".ops/metrics/collectors"
TARGET_FILE="$TARGET_DIR/$NAME.sh"
TEMPLATE=".gemini/skills/skill-metrics-manager/references/collector-template.sh"

mkdir -p "$TARGET_DIR"

if [ -f "$TARGET_FILE" ]; then
  echo "Error: File $TARGET_FILE already exists."
  exit 1
fi

cp "$TEMPLATE" "$TARGET_FILE"
chmod +x "$TARGET_FILE"

echo "Success: Created new collector at $TARGET_FILE"
echo "Please edit the file to implement your specific measurement logic."
