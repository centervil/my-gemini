---
name: skill-state-manager
description: プロジェクトの進捗状況（project_state.md やタスクリスト）を追跡し、自動的に同期・更新するスキル。
---

# Skill: State Manager

このスキルは、プロジェクトの進捗状況を追跡し、`.ops/project_state.md` や `docs/issues/[ID]/tasks.md` などのステータス管理ファイルを自動的に更新します。

## Capabilities

1.  **Issue Status Retrieval**: 現在取り組んでいるIssueのタイトル、本文、進捗状況を取得します。
2.  **State Synchronization**: 開発ログやタスクリストの変更内容を分析し、`.ops/project_state.md` の「Current Focus」や「Roadmap」を最新化します。
3.  **Task Management**: `docs/issues/[ID]/tasks.md` のチェックリストを自動的に更新し、完了したタスクにチェックを入れます。

## Usage Guidelines

### 1. Update Project State (プロジェクト状況の更新)

開発の節目（タスク完了時、フェーズ終了時）にこのスキルを実行し、プロジェクト全体のステータスファイルを同期します。

### 2. Update Issue Tasks (Issueタスクの更新)

実装が完了したタスクを検出し、対応する `tasks.md` の項目を自動的にチェック済みにします。

## CLI Usage

`scripts/update-state.sh` を使用して、手動または自動でステータスを更新できます。

```bash
# 特定のタスクを完了にする
bash .gemini/skills/skill-state-manager/scripts/update-state.sh <ISSUE_ID> "" <TASK_ID>

# Issue全体を完了にする（project_state.md も更新されます）
bash .gemini/skills/skill-state-manager/scripts/update-state.sh <ISSUE_ID> completed
```

---

## Resources
- **Project State**: `.ops/project_state.md`
- **Issue Documents**: `docs/issues/[ID]/`
