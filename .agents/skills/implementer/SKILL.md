---
name: implementer
description: Adds a new artifact to sloth — slash command, skill, or template. Generates correct frontmatter, places file in the right directory, updates README listing where relevant. For ADRs, defers to the decider skill.
---

# Implementer

## Inputs
- `type`: one of `command`, `skill`, `template`
- `name`: kebab-case identifier (e.g. `start-new`, `synthesizer`)
- `description`: one-sentence purpose
- `audience`: `plugin-users` (ships in plugin) or `sloth-internal` (only for sloth dev). Not applicable for `template`.

## Routing by type

### `command`
- Path: `commands/<name>.md` (plugin-users) OR `.agents/commands/<name>.md` (sloth-internal)
- Frontmatter: `description`
- Body: scripted instructions for the model. Keep terse. Use existing commands as the template.
- After write: if `plugin-users`, propose updating README's command list.

### `skill`
- Path: `skills/<name>/SKILL.md` (plugin-users) OR `.agents/skills/<name>/SKILL.md` (sloth-internal)
- Frontmatter: `name`, `description`
- Body structure: contract first (inputs / outputs), then logic, then hard rules. Use existing `synthesizer` (plugin) or `implementer` (this file) as the template.

### `template`
- Path: `templates/<name>` (file, not directory, unless multiple files needed)
- No frontmatter required.
- Templates are reference content used by skills (for example an `AGENTS.md` template or ADR template). Keep them minimal and parameterized with `<<placeholders>>`.

## Hard rules

- Always check the target path doesn't already exist. Refuse to overwrite without explicit user confirmation.
- File naming is **kebab-case**. Reject snake_case, PascalCase, camelCase.
- Frontmatter uses YAML, not TOML or JSON.
- After writing, surface the path and a one-line summary so the user can verify.
- Do **not** bump version in `plugin.json` from this skill — that's `/merge`'s job.
- Preview the proposed file content before writing. Always.
