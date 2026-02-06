# Metric Definitions

## 1. AI Autonomy
**Definition**: Measures the ratio of autonomous actions performed by the agent versus human interventions.
**Calculation**: `(Total Actions - Interventions) / Total Actions`
- **Data Source**: Audit logs (e.g., `.roo/audit_logs/roocode_tasklog.txt.md`).

## 2. Protocol Compliance
**Definition**: A score representing how well the project adheres to the established operational protocols and file structures.
**Calculation**: Sum of points for each satisfied check.
- **Checks (PoC)**:
    - `audit.toml` exists: 50 points
    - `README.md` exists: 50 points
    - **Total**: 100 points
