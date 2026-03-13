#!/bin/bash
CHURN_COUNT=$(git log --since="7 days ago" --oneline | wc -l)
LINES_CHANGED=$(git diff --shortstat "@ {7 days ago}" HEAD 2>/dev/null | awk '{print $4+$6}' || echo 0)
if [ -z "$LINES_CHANGED" ]; then LINES_CHANGED=0; fi

# Output JSON fragment
cat <<EOF
{
  "code_churn": {
    "commit_count_last_7_days": $CHURN_COUNT,
    "lines_changed_last_7_days": $LINES_CHANGED
  }
}
EOF
