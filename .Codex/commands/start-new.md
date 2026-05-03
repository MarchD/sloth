Interview the user about a new product idea and generate the minimal neutral starter brain.

Follow the neutral contract in `/Users/marynadubchak/Documents/projects-to-launch/sloth/commands/start-new.md`.

Codex adapter rules:

- Treat `AGENTS.md` as canonical output.
- Prefer `.agents/commands/` for generated workflow commands.
- Generate assistant-specific adapter files only if the user explicitly asks.
- Keep the first pass small; default to the minimal artifact set.
