# Claude Adapter Migration

## Goal

Keep the current Claude-compatible install path working while shifting the repo toward the adapter model.

## Current State

Live packaging still depends on:

- `.claude-plugin/plugin.json`
- `.claude-plugin/marketplace.json`

Local assistant-specific workflow files still exist in:

- `.claude/`

## Migration Steps

1. Keep `.claude-plugin/` as the active runtime install root until the host can resolve a relocated manifest.
2. Treat `adapters/claude/` as the documentation and planning home for Claude-specific behavior.
3. Define which adapter files are generated from neutral core inputs versus handwritten compatibility shims.
4. When safe, move Claude-specific metadata under `adapters/claude/` and leave only host-required shims at the root.

## Compatibility Shims

The repo can tolerate root-level shims if the host requires them, but those shims should:

- be minimal
- avoid redefining core behavior
- point back to the neutral contract

## Done Criteria

Claude adapter migration is complete when:

- adapter behavior is fully documented in `adapters/claude/`
- root-level Claude packaging is either removed or reduced to thin shims
- no product behavior is defined only in Claude-specific files
