---
name: skill-orchestration
description: AIエージェント（Mode）間の通信プロトコル（Orchestration Protocol）を定義・検証・管理するためのスキル。
---

# Skill: Orchestration Protocol

AIエージェント（Mode）間の通信プロトコル（Orchestration Protocol）を定義・検証・管理するためのスキルです。
Orchestrator が Worker Mode に指示を出す際（Dispatch） 、および Worker Mode が結果を報告する際（Result）のインターフェースを規定します。

## Components

### 1. Interaction Schema (`schemas/interaction.yaml`)
エージェント間通信の正解（Source of Truth）となるスキーマ定義です。
- **DispatchObject**: Orchestrator -> Worker
- **ResultObject**: Worker -> Orchestrator

### 2. Validation Tool (`scripts/validate_interaction.py`)
YAMLオブジェクトがスキーマに適合しているかを検証するス クリプトです。

#### Usage
```bash
# DispatchObject の検証
python3 .gemini/skills/skill-orchestration/scripts/validate_interaction.py dispatch "path/to/dispatch.yaml"

# ResultObject の検証
python3 .gemini/skills/skill-orchestration/scripts/validate_interaction.py result "path/to/result.yaml"
```


## Role Responsibilities

### Orchestrator
- **Dispatch時**: Worker Mode に対し、このプロトコル（`schemas/interaction.yaml`）に準拠した `ResultObject` を返すよう、**明示的に指示（Instruction）**しなければなりません。
- **Result受信時**: Worker からの戻り値を `validate_interaction.py` で検証し、不整合があれば修正を要求（またはエラー報告）してください。

### Worker Modes (Code, Reviewer, etc.)
- Orchestrator からの指示に従い、成果物と実行ログを `ResultObject` 形式で返却してください。
