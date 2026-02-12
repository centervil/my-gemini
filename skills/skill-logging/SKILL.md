---
name: skill-logging
description: 動作結果と期待値の乖離を JSON および Markdown 形式で記録する。
---

# Skill: Logging (JSON/Markdown)

## Definition
- 本 Skill は、セッションやタスクの実行結果を標準化された形式で記録するための純粋な手続きである。
- 記録される内容は、事後の監査および自動分析に利用される。

## Input Contract
- **Parameters**:
    - `session_id`: セッションの一意識別子。
    - `goal`: セッションまたはタスクの期待される成果。
    - `result`: 実際の実行結果。
    - `gap`: 期待値と結果の乖離（具体的記述）。
    - `action`: 次回に向けた改善アクション。
    - `format`: 出力形式 (`markdown` | `json` | `both`)。デフォルトは `both`。
- **Constraint**: `goal`, `result`, `session_id` が不足している場合、Skill はエラーを返す。

## Procedure (Stateless)
1.  **保存先ディレクトリの確認**: `development_logs/` ディレクトリが存在することを確認する。存在しない場合は作成する。
2.  **Markdown 出力の生成 (format が markdown または both の場合)**:
    - ファイル名: `development_logs/session-[session_id].md`
    - 内容:
        ```markdown
        # Session Audit Log: [session_id]
        - **Date**: [Current Date]
        - **Goal**: [goal]
        - **Result**: [result]
        - **Expectation Gap**: [gap]
        - **Action for Improvement**: [action]
        ```
3.  **JSON 出力の生成 (format が json または both の場合)**:
    - ファイル名: `development_logs/session-[session_id].json`
    - 内容:
        ```json
        {
          "session_id": "[session_id]",
          "timestamp": "[Current ISO Timestamp]",
          "audit": {
            "goal": "[goal]",
            "result": "[result]",
            "expectation_gap": "[gap]",
            "improvement_action": "[action]"
          }
        }
        ```
4.  **ファイル書き込み**: 生成されたコンテンツを指定されたパスに保存する。

## Output Contract
- **Result**: 指定された形式でのログファイル生成完了。
- **Artifacts**:
    - `development_logs/session-[session_id].md` (オプション)
    - `development_logs/session-[session_id].json` (オプション)