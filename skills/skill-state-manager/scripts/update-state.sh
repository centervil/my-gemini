#!/bin/bash

# Usage: ./update-state.sh [ISSUE_ID] [STATUS]
# STATUS can be "in_progress", "completed", etc.

ISSUE_ID=$1
STATUS=$2

if [ -z "$ISSUE_ID" ]; then
  echo "Usage: $0 [ISSUE_ID] [STATUS]"
  exit 1
fi

PROJECT_STATE=".ops/project_state.md"
TASKS_FILE="docs/issues/$ISSUE_ID/tasks.md"

# 1. Update project_state.md
# Search for the issue in roadmap and update status
if [ "$STATUS" == "completed" ]; then
  # Find the line with the issue and mark it as checked
  # This is a simple implementation that looks for "Implement State Management Skill" (Issue 2)
  # In a real scenario, this would be more dynamic.
  sed -i "s/\[ \] Implement State Management Skill/\[x\] Implement State Management Skill/g" "$PROJECT_STATE"
elif [ "$STATUS" == "in_progress" ]; then
  # Maybe add "(In Progress)" or similar
  sed -i "s/\[ \] Implement State Management Skill/\[ \] Implement State Management Skill (In Progress)/g" "$PROJECT_STATE"
fi

# 2. Update tasks.md
# For now, let's assume we want to check all items if status is completed
if [ "$STATUS" == "completed" ]; then
  sed -i "s/\[ \]/\[x\]/g" "$TASKS_FILE"
fi

echo "State updated for Issue #$ISSUE_ID to status: $STATUS"
