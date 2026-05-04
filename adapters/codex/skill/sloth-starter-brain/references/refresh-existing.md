## Goal

Update an existing project brain safely and cheaply. Reuse prior Sloth state, read the current repo, detect what actually changed, and propose targeted diffs for only the stale sections.

## Flow

### 1. Detect baseline

Read:

- `AGENTS.md`
- `CLAUDE.md`
- `.agents/commands/`
- `.claude/commands/`
- `.sloth/scan-summary.json`
- `.sloth/intake.json`
- `.sloth/brain-state.json`

Prefer `AGENTS.md` as canonical. If only `CLAUDE.md` exists, treat it as a legacy adapter and propose migration.

### 2. Compact rescan

Run the smallest deterministic scan that can detect drift:

- build files
- top-level structure
- test commands
- CI files
- docs filenames
- existing command directories
- recent activity via `git log --oneline -10`

### 3. Drift report

Show what changed since the last Sloth run:

- stack
- commands
- folder structure
- workflow files
- open questions
- missing or stale prior state

### 4. Confirm refresh scope

Ask only what is needed:

- canonical file
- whether to refresh only core workflow files or also ADR or principles or adapters
- whether any handwritten sections must not be touched

### 5. Propose targeted updates

Default refresh targets:

- `AGENTS.md`
- `docs/WORKFLOW.md`
- `.agents/commands/`
- `.sloth/*.json`

Optional refresh targets:

- `docs/PRINCIPLES.md`
- `docs/decisions/ADR-001-stack-as-is.md`
- assistant-specific adapters

### 6. Write only accepted diffs

Update only accepted sections or files. Never rewrite the whole project brain if a section patch is enough.
