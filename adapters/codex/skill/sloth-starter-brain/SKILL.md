---
name: sloth-starter-brain
description: Bootstrap or refresh an AGENTS.md-based project brain for new or existing software projects. Use when a user wants to scaffold project context, scan an existing repo into a workflow brain, or incrementally refresh Sloth-managed brain files.
---

# Sloth Starter Brain

Use this skill when the user wants Sloth behavior inside Codex.

## Choose the flow

- For a brand new project idea, follow [references/start-new.md](references/start-new.md).
- For an existing repository that needs an initial brain, follow [references/start-existing.md](references/start-existing.md).
- For a project Sloth already touched, follow [references/refresh-existing.md](references/refresh-existing.md).

## Core rules

- `AGENTS.md` is canonical when present.
- Prefer `.agents/commands/` for neutral workflow commands.
- Prefer compact local scans and `.sloth/*.json` persisted state over rereading the repo.
- Generate assistant-specific adapters only if the user explicitly wants them.
- Keep the first pass small. Default to the minimal useful output set.
