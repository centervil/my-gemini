---
name: skill-metrics-manager
description: プロジェクトのメトリクス収集（監査の実行、新規メトリクスの作成、ステータス分析）を管理するスキル。
---

# Skill: Metrics Manager

## Description
This skill manages the project's metrics collection system. It allows you to run audits (measurements) and create new metric collectors.
Use this skill when the user asks to:
- "Check the metrics" or "Run an audit".
- "Add a new metric" or "Measure something new".
- "Analyze the project's status".

## Usage

### 1. Run Audit (Measurement)
To collect current metrics and save them to the history:
```bash
bash .gemini/skills/skill-metrics-manager/scripts/run-audit.sh
```

### 2. Check Quality Gates
To verify if the current metrics meet the project's quality standards:
```bash
python3 .gemini/skills/skill-metrics-manager/scripts/check-gates.py
```
This script will:
1. Read the latest `.ops/audit_logs/metrics.json`.
2. Compare values against thresholds in `.ops/policies/metrics.yaml`.
3. Exit with code 1 if any "critical" gate fails.

### 3. Add New Metric
To create a new collector script:
```bash
.gemini/skills/skill-metrics-manager/scripts/create-collector.sh [metric_name]
```
- `metric_name`: A short, descriptive name (e.g., `check_todos`, `python_coverage`).
- The script is created in `.ops/metrics/collectors/`.
- **Action**: After running this command, you MUST edit the generated file to implement the logic.

## Metric Definitions
- **Core Metrics**: [references/METRICS.md](references/METRICS.md) (Standard metrics like Code Churn).
- **Project Metrics**: [.ops/metrics/METRICS.md](../../../../.ops/metrics/METRICS.md) (Project-specific definitions like Autonomy).
