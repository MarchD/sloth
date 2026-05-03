# Claude Adapter

## Purpose

This adapter packages Sloth for the current Claude-compatible plugin flow.

## Current live files

The active packaging files are still:

- `.claude-plugin/plugin.json`
- `.claude-plugin/marketplace.json`

The local assistant-specific workflow adapter still exists at:

- `.claude/`

## Responsibilities

This adapter should own:

- plugin manifest format
- marketplace manifest format
- assistant-specific installation instructions
- optional adapter generation for files like `CLAUDE.md`

It should not own:

- intake model
- scan model
- refresh model
- generated neutral outputs like `AGENTS.md` and `.agents/commands/`

## Migration direction

Short term:

- keep `.claude-plugin/` as the active install root
- document Claude-specific behavior here

Later:

- move Claude-specific packaging metadata under `adapters/claude/`
- keep only compatibility shims at the repo root if the host requires them
