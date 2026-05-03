# Adapters

This directory is the home for host-specific Sloth packaging.

The rule is:

- `commands/`, `skills/`, `templates/`, and `.sloth` state define the neutral product contract
- `adapters/<host>/` explains how that contract is exposed in a specific assistant
- adapter files should stay thin and should not fork the core behavior

Current status:

- `adapters/claude/` documents the active Claude-compatible packaging path
- `adapters/codex/` is a placeholder for the next host adapter

Until packaging is migrated, the live Claude-compatible manifest still lives in `.claude-plugin/`.

Every adapter should satisfy the shared contract in [docs/ADAPTER_CONTRACT.md](/Users/marynadubchak/Documents/projects-to-launch/sloth/docs/ADAPTER_CONTRACT.md:1).
