#!/bin/bash
npm test > /dev/null 2>&1
TEST_EXIT_CODE=$?
if [ $TEST_EXIT_CODE -eq 0 ]; then
  TEST_STATUS="Passed"
else
  TEST_STATUS="Failed"
fi

cat <<JSON
{
  "test_status": "$TEST_STATUS",
  "test_exit_code": $TEST_EXIT_CODE
}
JSON
