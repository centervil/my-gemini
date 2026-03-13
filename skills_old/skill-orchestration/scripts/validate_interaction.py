#!/usr/bin/env python3
import sys
import yaml
import json

def main():
    if len(sys.argv) < 3:
        print("Usage: validate_protocol.py [dispatch|result] [file_path|content]")
        sys.exit(1)

    type_ = sys.argv[1]
    input_data = sys.argv[2]

    try:
        if input_data.endswith('.yaml') or input_data.endswith('.yml'):
            with open(input_data, 'r') as f:
                data = yaml.safe_load(f)
        else:
            data = yaml.safe_load(input_data)
    except Exception as e:
        print(json.dumps({"valid": False, "error": f"Malformed YAML: {str(e)}"}))
        sys.exit(0)

    if type_ == "dispatch":
        valid, msg = validate_dispatch(data)
    elif type_ == "result":
        valid, msg = validate_result(data)
    else:
        valid, msg = False, f"Unknown type: {type_}"

    print(json.dumps({"valid": valid, "error": msg}))

def validate_dispatch(data):
    required = ["id", "mode", "goal", "ctx", "reqs", "scope"]
    for field in required:
        if field not in data:
            return False, f"Missing required field: {field}"
    
    if not isinstance(data.get("scope"), dict):
        return False, "field 'scope' must be a dictionary"
    
    return True, ""

def validate_result(data):
    required = ["ref", "status", "artifacts", "log", "err"]
    for field in required:
        if field not in data:
            return False, f"Missing required field: {field}"
    
    allowed_status = ["OK", "NG", "BLOCK", "ERROR"]
    if data["status"] not in allowed_status:
        return False, f"Invalid status: {data['status']}. Must be one of {allowed_status}"
    
    if not isinstance(data.get("artifacts"), list):
        return False, "field 'artifacts' must be a list"

    return True, ""

if __name__ == "__main__":
    main()
