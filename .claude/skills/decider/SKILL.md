---
name: decider
description: Writes a new ADR for sloth. Scans docs/decisions/ for existing ADR numbers, picks the next sequential number, fills the standard template, writes to disk after preview.
---

# Decider

## Inputs
- `topic`: one short phrase (becomes part of the filename and title)
- `context`: what problem this addresses
- `options`: alternatives considered (briefly)
- `decision`: what was chosen
- `consequences`: good and bad results expected

## Logic

1. List `docs/decisions/`, find highest existing `ADR-NNN-*.md` number.
2. Next number = highest + 1, zero-padded to 3 digits (`001`, `002`, …).
3. Filename: `ADR-<NNN>-<topic-kebab-case>.md`.
4. Fill template (below).
5. **Preview the proposed file to the user.** Do not write yet.
6. Write only after explicit accept.

## Template

```markdown
# ADR-<NNN>: <Title>

**Status:** Proposed
**Date:** <YYYY-MM-DD>

## Context

<context input>

## Options considered

<options input — bullet each>

## Decision

<decision input>

## Consequences

**Good:**
<positive consequences>

**Trade-offs:**
<negative consequences or things accepted as cost>
```

## Hard rules

- ADR numbers are sequential and never reused. If the highest is `003`, the next is `004` — never overwrite or insert mid-sequence.
- Date is today (YYYY-MM-DD).
- Status starts as `Proposed`. Mark `Accepted` or `Superseded` only on explicit user instruction.
- ADRs are immutable in spirit — to change a decision, write a new ADR that supersedes it. Don't edit the old one (except to flip its status to `Superseded`).
