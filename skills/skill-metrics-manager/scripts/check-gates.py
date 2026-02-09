#!/usr/bin/env python3
import json
import yaml
import sys
import os

def get_nested_value(data, key):
    parts = key.split('.')
    for part in parts:
        if isinstance(data, dict):
            data = data.get(part)
        else:
            return None
    return data

def check_threshold(value, threshold):
    if threshold.startswith('>='):
        t_val = float(threshold.replace('>=', '').strip())
        return float(value) >= t_val
    elif threshold.startswith('>'):
        t_val = float(threshold.replace('>', '').strip())
        return float(value) > t_val
    elif threshold.startswith('<='):
        t_val = float(threshold.replace('<=', '').strip())
        return float(value) <= t_val
    elif threshold.startswith('<'):
        t_val = float(threshold.replace('<', '').strip())
        return float(value) < t_val
    else:
        return str(value) == str(threshold)

def main():
    metrics_file = ".ops/audit_logs/metrics.json"
    policy_file = ".ops/policies/metrics.yaml"

    if not os.path.exists(metrics_file):
        print(f"Error: Metrics file {metrics_file} not found.")
        sys.exit(1)
    
    if not os.path.exists(policy_file):
        print(f"Error: Policy file {policy_file} not found.")
        sys.exit(1)

    with open(metrics_file, 'r') as f:
        metrics_data = json.load(f).get('metrics', {})

    with open(policy_file, 'r') as f:
        policy_data = yaml.safe_load(f)

    definitions = policy_data.get('metrics_definition', {}).get('code', [])
    rejection_policy = policy_data.get('rejection_policy', {})
    critical_keys = rejection_policy.get('critical', [])

    print("--- Quality Gate Report ---")
    failures = []
    
    for item in definitions:
        target = item.get('target')
        key = item.get('key')
        threshold = item.get('threshold')
        
        value = get_nested_value(metrics_data, key)
        
        if value is None:
            print(f"[ERROR] {target}: Key '{key}' not found in metrics.")
            if key in critical_keys:
                failures.append(target)
            continue

        passed = check_threshold(value, threshold)
        status = "PASS" if passed else "FAIL"
        
        print(f"[{status}] {target}: Actual={value}, Threshold={threshold}")
        
        if not passed and key in critical_keys:
            failures.append(target)

    print("---------------------------")
    if failures:
        print(f"REJECTED: The following critical gates failed: {', '.join(failures)}")
        sys.exit(1)
    else:
        print("ACCEPTED: All critical quality gates passed.")
        sys.exit(0)

if __name__ == "__main__":
    main()
