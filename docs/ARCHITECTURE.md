# Sloth Architecture

## Goal

Keep Sloth honest about what is assistant-neutral and what is host-specific.

The rule is simple:

- the **core** defines the product contract
- **host adapters** package that contract for a specific assistant
- **generated outputs** are what Sloth writes into the user's project

## Layers

### 1. Core

The core is assistant-neutral. It defines:

- the intake model
- the scan model
- the refresh model
- the generated project brain model
- the rules around provenance, preview-before-write, and incremental updates

Core artifacts in this repo:

- [README.md](/Users/marynadubchak/Documents/projects-to-launch/sloth/README.md)
- [skills/synthesizer/SKILL.md](/Users/marynadubchak/Documents/projects-to-launch/sloth/skills/synthesizer/SKILL.md)
- [commands/start-new.md](/Users/marynadubchak/Documents/projects-to-launch/sloth/commands/start-new.md)
- [commands/start-existing.md](/Users/marynadubchak/Documents/projects-to-launch/sloth/commands/start-existing.md)
- [commands/refresh-existing.md](/Users/marynadubchak/Documents/projects-to-launch/sloth/commands/refresh-existing.md)
- [templates/sloth-state-example.json](/Users/marynadubchak/Documents/projects-to-launch/sloth/templates/sloth-state-example.json)

Core outputs:

- `AGENTS.md`
- `docs/WORKFLOW.md`
- `.agents/commands/`
- `.sloth/scan-summary.json`
- `.sloth/intake.json`
- `.sloth/brain-state.json`

### 2. Host Adapters

Host adapters are thin wrappers that let a specific assistant run Sloth.

They should contain:

- packaging metadata
- assistant-specific installation surfaces
- assistant-specific wrapper files if needed

They should not redefine the product contract.

Current adapter in this repo:

- `.claude-plugin/`
- `adapters/claude/` documentation

Legacy local adapter still present:

- `.claude/`

Future adapters could include:

- `adapters/codex/`
- other host-specific packaging roots

### 3. Generated Outputs

Generated outputs live in the user's project, not in Sloth's implementation repo.

There are two categories:

- canonical neutral outputs
- optional assistant-specific adapters

Canonical neutral outputs:

- `AGENTS.md`
- `docs/WORKFLOW.md`
- `.agents/commands/*`
- `.sloth/*.json`

Optional adapters:

- `CLAUDE.md`
- `.claude/commands/*`

## Ownership Rules

### Core owns

- file schemas
- refresh rules
- section ownership rules
- what "minimal default output" means
- provenance requirements

### Adapters own

- how commands are exposed to the host
- host-specific packaging/versioning
- adapter generation from the neutral core
- compatibility shims required by the host

### Generated project files own

- project-specific context
- user-confirmed workflow decisions
- manually written notes outside Sloth-managed sections

## Invariants

- `AGENTS.md` is the canonical project brain when present.
- Assistant-specific files are adapters, not the source of truth.
- Refresh patches sections before rewriting files.
- Compact scan state in `.sloth/*.json` is the refresh baseline.
- Host adapters should be replaceable without changing the core contract.

## Recommended Repo Direction

Target shape:

```text
sloth/
├── core/ or current neutral root files
├── adapters/
│   ├── claude/
│   └── <future-host>/
├── commands/
├── skills/
├── templates/
└── docs/
```

Pragmatic transition path from the current repo:

1. Keep `commands/` and `skills/` as the current neutral contract surface.
2. Treat `.claude-plugin/` as the first live adapter, not the product identity.
3. Keep `.claude/` only as a legacy local adapter until a neutral local workflow fully replaces it.
4. Use `adapters/` as the home for host-specific work.
5. Add a second host adapter before claiming full assistant-agnostic distribution.
6. Require every adapter to satisfy the checklist in `docs/ADAPTER_CONTRACT.md`.

## Non-goals

- Do not maintain duplicate product logic in each adapter.
- Do not let `CLAUDE.md` regain canonical status.
- Do not require full repo rescans for normal refreshes.
