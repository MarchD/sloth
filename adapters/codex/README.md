# Codex Adapter

## Status

Live at the skill-install layer. Sloth now ships as a self-contained Codex skill package. There is still no separate Codex packaging manifest beyond the skill itself.

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

Primary Codex surface:

- `adapters/codex/skill/sloth-starter-brain/`

Compatibility wrappers still exist at:

- `.Codex/commands/start-new.md`
- `.Codex/commands/start-existing.md`
- `.Codex/commands/refresh-existing.md`

The skill and wrappers keep the canonical project outputs unchanged:

- `AGENTS.md`
- `.agents/commands/`
- `.sloth/*.json`

This direction is the current accepted approach in [docs/decisions/ADR-002-codex-adapter-surface.md](/Users/marynadubchak/Documents/projects-to-launch/sloth/docs/decisions/ADR-002-codex-adapter-surface.md:1).

## Install

Install instructions are in [adapters/codex/INSTALL.md](/Users/marynadubchak/Documents/projects-to-launch/sloth/adapters/codex/INSTALL.md:1).
The current install helper is `adapters/codex/install.sh`.
The same file also contains a ready-to-copy remote install prompt for Codex.

## Open questions

- Does Codex need packaging metadata analogous to `.claude-plugin/`, or a different install surface entirely?
- Are Codex-specific wrapper files needed inside user projects, or is `AGENTS.md` enough?
- Should the Codex adapter ever need more than `.Codex/commands/` wrappers and documentation?

## Update path

For now, updating the Codex adapter means updating:

- the neutral contracts in `commands/`
- the Codex skill package in `adapters/codex/skill/`
- the compatibility wrappers in `.Codex/commands/`
- the Codex adapter docs in `adapters/codex/`
- the install helper in `adapters/codex/install.sh`

There is no separate Codex package version yet, but the update path no longer depends on Claude-specific packaging.

## Non-goals

- do not duplicate the core synthesis contract here
- do not redefine the canonical project brain away from `AGENTS.md`
- do not fork refresh/state behavior from `.sloth/*.json`

## Exit criteria

This adapter becomes real only when it meets the checklist in [docs/ADAPTER_CONTRACT.md](/Users/marynadubchak/Documents/projects-to-launch/sloth/docs/ADAPTER_CONTRACT.md:1).
