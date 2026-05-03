---
description: Brownfield — run a compact repo scan, confirm only the unknowns, and generate the smallest useful starter brain for an existing project. Never invents history.
---

You are running the **brownfield onboarding flow** for an existing project.

## Goal

Take a project that already has code, conventions, and history, and retrofit an understand -> plan -> implement -> guide -> sync -> merge workflow onto it without lying about what is already there or burning tokens on repeated full-repo synthesis.

## Flow

### 1. Compact scan pass (you do this first, before any questions)

Build an honest "as-is" picture with the smallest deterministic scan possible. Prefer shell commands and compact structured output over pasting file contents into the conversation.

- Build files: `package.json`, `pom.xml`, `pyproject.toml`, `Cargo.toml`, `go.mod`, `Gemfile`, etc.
- Top-level directory structure (one level deep)
- Short README summary only if needed
- Any existing `docs/` contents by filename, not full contents
- CI files (`.github/workflows/`, `.gitlab-ci.yml`, etc.)
- `git log --oneline -10` for recent activity signal
- Existing `AGENTS.md`, `CLAUDE.md`, `.agents/`, and `.claude/` if present

Write the scan result to a compact persisted state when possible, for example `.sloth/scan-summary.json`.

Output a compact summary covering:
- stack
- structure
- testing setup
- CI status
- recent activity
- existing agent tooling
- likely workflow pain points

Do not inline large file contents unless the scan leaves a critical ambiguity.

### 2. Confirm + correct (~2 questions)

Show the summary and ask the user to correct only what matters. The scan WILL miss something subtle, but this step should stay short.

### 3. Forward pass (~4 questions)

- What's painful right now in your workflow?
- What's the next milestone you care about?
- Where do you most often lose context today: understanding the repo, making a plan, implementing, reviewing, or shipping?
- Which workflow rituals matter to you (`/understand`, `/plan`, `/implement`, `/guide`, `/sync`, `/merge`, `/decide`)?

Only ask follow-up questions that the compact scan could not answer.

### 4. Principles pass (~3 questions)
Capture non-negotiables that should anchor future decisions. Anchor in the *current* project — what's already true and worth protecting, plus what the user wants to enforce going forward.
- Testing stance: what's the bar for code to land? (Detect from CI/test files first, then confirm with the user.)
- Any security or privacy lines this project will not cross?
- One or two "we never X" rules worth codifying? (Existing patterns the team already follows count.)

### 5. Wrap-up — open questions
Before synthesis, list every ambiguity from the scan or interview that the user did **not** resolve (e.g., "scan saw two test runners — which is canonical?", "no clear owner of the deploy script"). Do not force answers. Ask: "Resolve any of these now, or ship them as known-unknowns?" Unresolved items become an `OPEN_QUESTIONS` section in `AGENTS.md`.

## Synthesis (defensive and minimal)

Generate **honestly**:

- `AGENTS.md` — *descriptive* of as-is, not aspirational, plus an `OPEN_QUESTIONS` section. If `AGENTS.md` or `CLAUDE.md` already exists, propose a diff and a migration note, never overwrite silently.
- `docs/WORKFLOW.md` — a repo-specific workflow map for the next real milestone.
- `.agents/commands/` — repo-tuned commands for at least `/understand`, `/plan`, `/implement`, `/sync`, and `/merge`. Add `/guide` and `/decide` only if the user wants them.
- Persisted intake/state — compact machine-readable state for future reruns.

Generate these only if they add clear value for the current repo:
- `docs/decisions/ADR-001-stack-as-is.md`
- `docs/PRINCIPLES.md`
- Optional assistant-specific adapters (`CLAUDE.md`, `.claude/commands/`, etc.) only if the user explicitly wants them. These are wrappers around the neutral brain, not the canonical source.
- `MEMORY.md` seed — empty index. **No fabricated past sessions or memories.** Memory grows from here.
- **Do NOT generate retroactive issues.** Issues already exist or don't need to.

## Critical rules

- **Never invent history.** No retroactive ADRs that pretend decisions were considered. No memory entries about sessions that didn't happen. Lying about provenance poisons the brain.
- **Scan informs every generator.** Snake_case files → snake_case templates. Tests in `tests/` → templates put tests in `tests/`. Detected conventions flow into every artifact.
- **Preview before write.** Show the bundle, let the user accept/edit/reject piece by piece. This is the AI-hallucination guard.
- **Optimize for brownfield momentum.** The command pack must reduce friction for the next real milestone, not just document the repo elegantly.
- **Prefer neutral artifacts.** `AGENTS.md` and `.agents/commands/` are the canonical outputs unless the user asks for assistant-specific adapters too.
- **Prefer local commands over token-heavy chat.** Let deterministic shell scans do extraction; use the model for synthesis and unresolved judgment calls.
- **Reuse saved state.** If a prior scan summary exists and the repo has not changed materially, update incrementally instead of rescanning.

## Important

- Walking-skeleton version. The full scan/synthesis logic will live in the `synthesizer` skill — for now, run scan and synthesis inline.
