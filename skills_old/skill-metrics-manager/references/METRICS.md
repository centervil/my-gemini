# Core Metric Definitions

These metrics are standard across all projects using the Gemini CLI.

## 1. Code Churn
**Definition**: Measures the volume of code changes over a specific period (default: 7 days).
- **Metrics**:
  - `commit_count_last_7_days`: Number of git commits.
  - `lines_changed_last_7_days`: Number of lines inserted or deleted.
- **Collector**: `collectors/code_churn.sh`

## 2. Test Status
**Definition**: The result of the project's primary test suite execution.
- **Metrics**:
  - `test_status`: "Passed" or "Failed".
  - `test_exit_code`: The exit code of the test command.
- **Collector**: `collectors/test_status.sh`