#!/bin/bash

VALID_DISPATCH='
id: "task-1"
mode: "code"
goal: "test"
ctx: ["ctx1"]
reqs: ["req1"]
scope:
  read: ["*"]
  edit: ["*"]
'

INVALID_DISPATCH='
id: "task-1"
mode: "code"
goal: "test"
# missing ctx, reqs, scope
'

VALID_RESULT='
ref: "task-1"
status: "OK"
artifacts: []
log: "done"
err: null
'

INVALID_RESULT='
ref: "task-1"
status: "UNKNOWN"
artifacts: "not a list"
log: "done"
err: null
'

echo "Testing Valid Dispatch..."
python3 .gemini/skills/skill-orchestration/scripts/validate_interaction.py dispatch "$VALID_DISPATCH"
echo "Testing Invalid Dispatch..."
python3 .gemini/skills/skill-orchestration/scripts/validate_interaction.py dispatch "$INVALID_DISPATCH"
echo "Testing Valid Result..."
python3 .gemini/skills/skill-orchestration/scripts/validate_interaction.py result "$VALID_RESULT"
echo "Testing Invalid Result..."
python3 .gemini/skills/skill-orchestration/scripts/validate_interaction.py result "$INVALID_RESULT"
