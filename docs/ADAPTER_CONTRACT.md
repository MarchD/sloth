# Adapter Contract

## Purpose

Every host adapter should answer the same set of questions so Sloth can stay neutral at the core and specific only at the edges.

## Required Questions

Each adapter must define:

1. How is Sloth installed in this host?
2. How are user-facing commands exposed?
3. How are core commands mapped to the host surface?
4. Which files remain canonical in the user's project?
5. Which files are optional host-specific adapters?
6. How does refresh work without forking the core state model?
7. What compatibility shims are needed during migration?

## Required Inputs From Core

An adapter consumes the neutral contract, not raw product intent. Minimum inputs:

- `commands/`
- `skills/`
- `templates/`
- `.sloth/scan-summary.json`
- `.sloth/intake.json`
- `.sloth/brain-state.json`

## Required Outputs

Each adapter should document:

- install path
- packaging files
- command mapping
- optional adapter files generated into user projects
- update path for the adapter itself

## Invariants

- `AGENTS.md` stays canonical when present.
- `.agents/commands/` stays canonical for neutral workflow commands.
- `.sloth/*.json` stays canonical for persisted refresh state.
- host-specific files must be derivable from the neutral contract.

## Minimum Adapter Checklist

- installation documented
- live packaging location documented
- command exposure documented
- canonical-vs-adapter file ownership documented
- refresh behavior documented
- migration path documented

## Claude-Specific Current Status

Claude currently passes only part of the checklist:

- install path: yes
- packaging files: yes
- command exposure: partial
- canonical-vs-adapter ownership: documented
- refresh behavior: documented at core level
- migration path: partial

## Codex Adapter Exit Criteria

Do not call the Codex adapter real until it has:

- a concrete install or invocation surface
- mapped command exposure for `/start-new`, `/start-existing`, `/refresh-existing`
- documented relationship to `AGENTS.md`, `.agents/commands/`, and `.sloth/*.json`
- an update story that does not depend on Claude-specific packaging

Current status:

- invocation surface: yes, via `.Codex/commands/`
- mapped command exposure: yes for the three core flows
- canonical file relationship: documented
- independent update story: not yet
