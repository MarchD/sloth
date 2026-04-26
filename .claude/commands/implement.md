---
description: Add a new artifact to sloth — slash command, skill, or template. Branches by type and delegates to the implementer skill. For ADRs, use /decide instead.
---

Use the `implementer` skill to add a new artifact to sloth.

Ask the user first: **what are you adding?**
- `command` — a new slash command (in `commands/` for plugin users, or `.claude/commands/` for sloth-internal)
- `skill` — a new skill (in `skills/` for plugin users, or `.claude/skills/` for sloth-internal)
- `template` — a new file in `templates/`
- `adr` — defer to `/decide` instead

Then ask for:
- `name` — kebab-case identifier
- `description` — one sentence
- `audience` — `plugin-users` or `sloth-internal` (for commands and skills)

Hand off to `implementer` with those four inputs.
