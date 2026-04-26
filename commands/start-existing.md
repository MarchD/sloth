---
description: Brownfield — scan an existing repo, confirm what you found with the user, then generate a non-invasive starter brain (descriptive CLAUDE.md, retroactive ADR-001 snapshot, stack-tuned slash commands, memory seed). Never invents history.
---

You are running the **brownfield onboarding flow** for an existing project.

## Goal

Take a project that already has code, conventions, and history, and retrofit the implement → guide → sync → merge workflow onto it — without lying about what's already there.

## Flow

### 1. Scan pass (you do this first, before any questions)

Read the repo to build an honest "as-is" picture:

- Build files: `package.json`, `pom.xml`, `pyproject.toml`, `Cargo.toml`, `go.mod`, `Gemfile`, etc.
- `README.md` (top-level)
- Top-level directory structure (one level deep)
- Any existing `docs/` contents
- CI files (`.github/workflows/`, `.gitlab-ci.yml`, etc.)
- `git log --oneline -50` for recent activity signal
- Existing `CLAUDE.md` and `.claude/` if present

Output a "here's what I think this project is" summary covering: stack, structure, testing setup, CI status, recent activity, existing AI tooling.

### 2. Confirm + correct (~2 questions)

Show the summary and ask the user to correct anything wrong. The scan WILL miss something subtle — this step is non-negotiable.

### 3. Forward pass (~5 questions)

- What's painful right now in your workflow?
- What's the next milestone you care about?
- Which workflow rituals matter to you (`/implement`, `/guide`, `/sync`, `/merge`, `/decide`)?
- Do you use GitHub issues, or something else (Linear, JIRA, none)?
- Do you want `/guide` retroactively (cover existing code), only for new code, or skip it?

## Synthesis (defensive)

Generate **honestly**:

- `CLAUDE.md` — *descriptive* of as-is, not aspirational. If existing CLAUDE.md is present, propose a diff, never overwrite.
- `docs/decisions/ADR-001-stack-as-is.md` — explicitly labeled "Retroactive snapshot of stack as of <date>" so it doesn't pretend the decision was deliberated when it wasn't.
- `.claude/commands/` — slash commands tuned to **detected** conventions (file naming, test location, build tool). Diff against any existing `.claude/commands/`.
- `MEMORY.md` seed — empty index. **No fabricated past sessions or memories.** Memory grows from here.
- **Do NOT generate retroactive issues.** Issues already exist or don't need to.

## Critical rules

- **Never invent history.** No retroactive ADRs that pretend decisions were considered. No memory entries about sessions that didn't happen. Lying about provenance poisons the brain.
- **Scan informs every generator.** Snake_case files → snake_case templates. Tests in `tests/` → templates put tests in `tests/`. Detected conventions flow into every artifact.
- **Preview before write.** Show the bundle, let the user accept/edit/reject piece by piece. This is the AI-hallucination guard.

## Important

- Walking-skeleton version. The full scan/synthesis logic will live in the `synthesizer` skill — for now, run scan and synthesis inline.
