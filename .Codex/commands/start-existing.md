Scan an existing repo with a compact local-first pass, ask only unresolved questions, and generate the smallest useful neutral starter brain.

Follow the neutral contract in `/Users/marynadubchak/Documents/projects-to-launch/sloth/commands/start-existing.md`.

Codex adapter rules:

- Treat `AGENTS.md` as canonical output.
- Persist scan state in `.sloth/*.json` for refreshes.
- Prefer deterministic shell scans over token-heavy chat.
- Generate Codex-specific wrappers only when the user asks for them.
