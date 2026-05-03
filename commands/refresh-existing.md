---
description: Refresh a project that Sloth has already touched. Read existing brain files, run a compact rescan, detect drift, and propose minimal section-by-section updates instead of rerunning onboarding.
---

You are running the **brownfield refresh flow** for a project that already has Sloth-generated artifacts or a manually maintained project brain.

## Goal

Update an existing project brain safely and cheaply. Reuse prior Sloth state, read the current repo, detect what actually changed, and propose targeted diffs for only the stale sections.

## Flow

### 1. Detect baseline

Read the existing project brain and update state if present:

- `AGENTS.md`
- `CLAUDE.md`
- `.agents/commands/`
- `.claude/commands/`
- `.sloth/scan-summary.json`
- `.sloth/intake.json`
- `.sloth/brain-state.json`

Decide which file is canonical:

- Prefer `AGENTS.md` if present
- If only `CLAUDE.md` exists, treat it as a legacy adapter and propose migration to `AGENTS.md`
- If both exist, prefer `AGENTS.md` and treat `CLAUDE.md` as an adapter unless the user says otherwise

### 2. Compact rescan

Run the smallest deterministic scan that can detect drift:

- build files
- top-level structure
- test command(s)
- CI files
- docs filenames
- existing command directories
- recent activity via `git log --oneline -10`
- optionally changed files since the last refresh if the prior state includes a baseline

Do not reread large files unless the diff cannot be understood otherwise.

### 3. Drift report

Show a compact "what changed since the last Sloth run" summary:

- stack changed / unchanged
- commands changed / unchanged
- folder structure changed / unchanged
- workflow files changed / unchanged
- open questions resolved / still unresolved / newly introduced
- whether prior Sloth state is missing or stale

### 4. Confirm refresh scope

Ask only the questions required to refresh stale sections. Typical questions:

- Which current file should be canonical: `AGENTS.md`, `CLAUDE.md`, or both?
- Do you want to refresh only core workflow files, or also ADR/principles/adapters?
- Are there handwritten sections that Sloth must not touch?

### 5. Propose targeted updates

Default refresh targets:

- `AGENTS.md`
- `docs/WORKFLOW.md`
- `.agents/commands/`
- `.sloth/*.json`

Optional refresh targets:

- `docs/PRINCIPLES.md`
- `docs/decisions/ADR-001-stack-as-is.md`
- assistant-specific adapters such as `CLAUDE.md` and `.claude/commands/`

### 6. Write only accepted diffs

Update only accepted sections or files. Never rewrite the whole project brain if a section-level patch is enough.

## Section ownership rules

When updating existing markdown files:

- Prefer section-by-section updates (`## Stack`, `## Commands`, `## Conventions`, `## OPEN_QUESTIONS`, etc.)
- Preserve handwritten sections unless the user explicitly asks to replace them
- Add or update provenance lines such as `Last refreshed by Sloth: YYYY-MM-DD`
- Mark generated sections clearly if the file mixes manual and generated content

## `.sloth` state contract

Use these persisted files:

- `.sloth/scan-summary.json` — compact machine summary of the repo
- `.sloth/intake.json` — normalized user-confirmed answers and preferences
- `.sloth/brain-state.json` — what Sloth previously generated, which file is canonical, and when it was last refreshed

If any are missing, recreate them from the current repo and the current refresh interview.

## Hard rules

- Never overwrite a user-edited file silently.
- Never assume unchanged state without scanning for drift.
- Never replace a full file when a section patch is sufficient.
- Never invent prior Sloth runs if `.sloth` state is missing.
- Prefer minimal refreshes. If only commands drifted, do not regenerate ADRs or principles.
