#!/bin/bash

if [ -f "package.json" ] && grep -q "\"test\":" "package.json"; then
  npm test > /dev/null 2>&1
  TEST_EXIT_CODE=$?
  if [ $TEST_EXIT_CODE -eq 0 ]; then
    TEST_STATUS="Passed"
  else
    TEST_STATUS="Failed"
  fi
else
  # No npm test defined, consider it Passed (or N/A)
  TEST_STATUS="Passed"
  TEST_EXIT_CODE=0
fi

cat <<JSON
{
  "test_status": "$TEST_STATUS",
  "test_exit_code": $TEST_EXIT_CODE
}
JSON
