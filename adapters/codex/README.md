# Codex Adapter

## Status

Partially live. Codex command wrappers now exist for the core flows, and ADR-002 defines wrappers as the supported first adapter surface. There is still no Codex-specific packaging manifest.

## Goal

Add a second host adapter so Sloth is assistant-agnostic at the distribution layer, not just in generated project outputs.

## Expected responsibilities

- Codex-specific packaging or install surface
- optional Codex-specific wrapper generation if needed
- mapping from the neutral Sloth contract to Codex command surfaces

## Minimum MVP

The first real Codex adapter should document:

- how Sloth is installed or invoked from Codex
- how `/start-new`, `/start-existing`, and `/refresh-existing` are exposed
- whether Codex needs any project-level adapter files beyond `AGENTS.md`, `.agents/commands/`, and `.sloth/*.json`
- how updates to the adapter itself are distributed

## Current invocation surface

Codex-facing wrappers live at:

- `.Codex/commands/start-new.md`
- `.Codex/commands/start-existing.md`
- `.Codex/commands/refresh-existing.md`

These wrappers delegate to the neutral contracts in `commands/` and keep the canonical project outputs unchanged:

- `AGENTS.md`
- `.agents/commands/`
- `.sloth/*.json`

This direction is the current accepted approach in [docs/decisions/ADR-002-codex-adapter-surface.md](/Users/marynadubchak/Documents/projects-to-launch/sloth/docs/decisions/ADR-002-codex-adapter-surface.md:1).

## Open questions

- Does Codex need packaging metadata analogous to `.claude-plugin/`, or a different install surface entirely?
- Are Codex-specific wrapper files needed inside user projects, or is `AGENTS.md` enough?
- Should the Codex adapter ever need more than `.Codex/commands/` wrappers and documentation?

## Update path

For now, updating the Codex adapter means updating:

- the neutral contracts in `commands/`
- the Codex wrappers in `.Codex/commands/`
- the Codex adapter docs in `adapters/codex/`

There is no separate Codex package version yet.

## Non-goals

- do not duplicate the core synthesis contract here
- do not redefine the canonical project brain away from `AGENTS.md`
- do not fork refresh/state behavior from `.sloth/*.json`

## Exit criteria

This adapter becomes real only when it meets the checklist in [docs/ADAPTER_CONTRACT.md](/Users/marynadubchak/Documents/projects-to-launch/sloth/docs/ADAPTER_CONTRACT.md:1).
