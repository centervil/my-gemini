#!/bin/bash

# Enhanced State Management Script
# Usage: ./update-state.sh <ISSUE_ID> [STATUS] [TASK_ID]

ISSUE_ID=$1
STATUS=$2
TASK_ID=$3

if [ -z "$ISSUE_ID" ]; then
  echo "Usage: $0 <ISSUE_ID> [STATUS] [TASK_ID]"
  exit 1
fi

PROJECT_STATE=".ops/project_state.md"
TASKS_FILE="docs/issues/$ISSUE_ID/tasks.md"

# 1. Fetch Issue Title from GitHub (Source of Truth) or local requirements
ISSUE_TITLE=$(gh issue view "$ISSUE_ID" --json title -q .title 2>/dev/null)
if [ -z "$ISSUE_TITLE" ]; then
  # Fallback to local requirements.md if gh fails or offline
  REQ_FILE="docs/issues/$ISSUE_ID/requirements.md"
  if [ -f "$REQ_FILE" ]; then
    ISSUE_TITLE=$(grep "^# Requirements:" "$REQ_FILE" | sed -E "s/^# Requirements: Issue #$ISSUE_ID - //")
  fi
fi

echo "Processing Issue #$ISSUE_ID: $ISSUE_TITLE"

# 2. Update project_state.md (Roadmap)
if [ -n "$ISSUE_TITLE" ] && [ -f "$PROJECT_STATE" ]; then
  if [ "$STATUS" == "completed" ]; then
    # Escape special characters for sed (/, ., *, [, ], &)
    ESCAPED_TITLE=$(echo "$ISSUE_TITLE" | sed 's/[/.*[\]&]/\\&/g')
    # Update checkbox to [x]
    sed -i "s/\[ \] $ESCAPED_TITLE/\[x\] $ESCAPED_TITLE/g" "$PROJECT_STATE"
    echo "Marked '$ISSUE_TITLE' as completed in $PROJECT_STATE"
  elif [ "$STATUS" == "in_progress" ]; then
    # Add "(In Progress)" if not already there, but don't check it yet
    # This is optional and depends on project style
    if ! grep -q "$ISSUE_TITLE (In Progress)" "$PROJECT_STATE"; then
       sed -i "s/\[ \] $ESCAPED_TITLE/\[ \] $ISSUE_TITLE (In Progress)/g" "$PROJECT_STATE"
    fi
  fi
fi

# 3. Update tasks.md
if [ -f "$TASKS_FILE" ]; then
  if [ -n "$TASK_ID" ]; then
    # Update specific task by ID marker <!-- id: TASK_ID -->
    sed -i "s/\[ \] \(.*\)<!-- id: $TASK_ID -->/\[x\] \1<!-- id: $TASK_ID -->/g" "$TASKS_FILE"
    echo "Marked task ID $TASK_ID as completed in $TASKS_FILE"
  elif [ "$STATUS" == "completed" ]; then
    # Mark all tasks as completed
    sed -i "s/\[ \]/\[x\]/g" "$TASKS_FILE"
    echo "Marked all tasks in $TASKS_FILE as completed"
  fi
fi

# 4. Update Current Focus in project_state.md if status is in_progress
if [ "$STATUS" == "in_progress" ] && [ -f "$PROJECT_STATE" ]; then
  # This is a bit more complex, might need to replace a whole block
  # For now, let's just log it.
  echo "Issue #$ISSUE_ID is now the focus."
fi