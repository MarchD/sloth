---
description: Greenfield — interview the user about a new product idea, then generate the starter brain (CLAUDE.md, ADR-001, vision doc, 3 issues, slash commands, memory seed).
---

You are running the **greenfield onboarding flow** for a new project.

## Goal

Walk the user through a short, structured interview about their product idea. Then synthesize the answers into a "starter brain" — a directory of artifacts that gives the project a working CLAUDE.md, ADR-001, vision doc, 3 starter issues, stack-tuned slash commands, and a memory seed.

## Flow

Run these passes **in order**, one question at a time. Wait for each answer before moving on. Do not generate anything until the user has confirmed the proposed structure.

### 1. Vision pass (~5 questions)
- One-line pitch: what is this in one sentence?
- Who is the *first* user (not the market — one specific person)?
- What is the core loop in one sentence (what does the user do, what do they get back)?
- What does success look like in 30 days?
- What are you explicitly *not* building?

### 2. Tech pass (~3 questions)
- Preferred language/stack and your experience level with it
- Hosting target (local only, hobby, production)
- Any hard constraints (existing infra, mandated tools, budget)

### 3. Workflow pass (~3 questions)
- Solo or team?
- Is this a learning project or a shipping project? (Optimizes differently.)
- Do you want the `/guide` ritual (every implementation produces a plain-language explanation), or skip it?

## Synthesis

After the interview, **show the proposed structure before writing any files.** Bundle:

- `CLAUDE.md` — project overview, stack, commands, conventions
- `docs/product/VISION.md` — pitch, first user, core loop, success criteria, non-goals
- `docs/decisions/ADR-001-tech-stack.md` — the stack choice and why
- `docs/PROGRESS_TRACKER.md` — empty board with first 3 issues seeded
- `.claude/commands/` — slash commands tuned to the chosen stack (at minimum: `/implement`, `/sync`, `/merge`)
- `MEMORY.md` seed — empty index with a one-line note that memory grows from here

Let the user accept, edit, or reject each artifact piece by piece. Never overwrite an existing CLAUDE.md without explicit confirmation.

## Important

- This is the walking-skeleton version. The full interview/synthesis logic will live in the `synthesizer` skill — for now, run the interview by hand and produce the artifacts inline.
- Do NOT invent features the user didn't ask for. If they said "no auth in v1," the scaffolding has no auth.
- Stack-tune everything. Conventions, file paths, test layout, slash-command templates all reflect the declared stack.
