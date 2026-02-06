#!/bin/bash

# [Title] Metrics Collector
# Description: [Description of what this collector measures]

# 1. Perform measurement logic here
# Example: COUNT=$(grep -r "TODO" . | wc -l)
VALUE=0

# 2. Output result as a JSON fragment
# Ensure the key is unique across all collectors.
cat <<JSON
{
  "my_new_metric": {
    "value": $VALUE,
    "unit": "count"
  }
}
JSON
