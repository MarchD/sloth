Refresh a project that Sloth already touched by reading the existing brain, running a compact rescan, and proposing minimal diffs.

Follow the neutral contract in `/Users/marynadubchak/Documents/projects-to-launch/sloth/commands/refresh-existing.md`.

Codex adapter rules:

- Patch sections before rewriting whole files.
- Reuse `.sloth/scan-summary.json`, `.sloth/intake.json`, and `.sloth/brain-state.json` when present.
- Treat `AGENTS.md` as canonical when present; `CLAUDE.md` is a legacy adapter.
- Preserve handwritten sections unless the user explicitly wants replacement.
