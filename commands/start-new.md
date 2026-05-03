---
description: Greenfield — interview the user about a new product idea, then generate the starter brain (AGENTS.md, workflow map, ADR-001, vision doc, principles, 3 issues, repo-tuned commands, memory seed).
---

You are running the **greenfield onboarding flow** for a new project.

## Goal

Walk the user through a short, structured interview about their product idea. Then synthesize the answers into a "starter brain" — a directory of artifacts that gives the project a working `AGENTS.md`, `docs/WORKFLOW.md`, ADR-001, a vision doc, 3 starter issues, repo-tuned commands, and a memory seed.

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
- Do you want a lightweight `/plan` step before `/implement`, or should implementation start directly from issues?

### 4. Principles pass (~3 questions)
Capture non-negotiables that should anchor every future decision. Keep these short and durable.
- What's your testing stance? (e.g., "tests required for shipping code", "spike-first then test", "no tests in v1 — clearly time-boxed")
- Any security or privacy lines you will not cross? (e.g., "no third-party analytics", "no storing PII unencrypted")
- One or two "we never X" rules for this project? (e.g., "no premature abstractions", "no feature flags until we have real users")

### 5. Wrap-up — open questions
Before synthesis, list every ambiguity you noticed during the interview that the user did **not** resolve. Do not force answers. Show the list and ask: "Resolve any of these now, or ship them as known-unknowns in the brain?" Whatever stays unresolved becomes an `OPEN_QUESTIONS` section in `AGENTS.md` so future sessions know what is still in flux.

## Synthesis

After the interview, **show the proposed structure before writing any files.** Bundle the minimum useful set first:

- `AGENTS.md` — project overview, stack, commands, conventions, plus an `OPEN_QUESTIONS` section for unresolved ambiguities
- `docs/WORKFLOW.md` — how this project moves from understanding to planning to implementation to sync and merge
- `docs/product/VISION.md` — pitch, first user, core loop, success criteria, **explicit `Non-goals` section**
- `.agents/commands/` — repo-tuned commands (at minimum: `/plan`, `/implement`, `/sync`, `/merge`; add `/guide` if requested)
- `docs/PRINCIPLES.md`, `docs/decisions/ADR-001-tech-stack.md`, and `docs/PROGRESS_TRACKER.md` only if the user wants the fuller pack
- Optional assistant-specific adapters (`CLAUDE.md`, `.claude/commands/`, etc.) only if the user explicitly wants them
- `MEMORY.md` seed — empty index with a one-line note that memory grows from here

Let the user accept, edit, or reject each artifact piece by piece. Never overwrite an existing `AGENTS.md` or `CLAUDE.md` without explicit confirmation.

## Important

- This is the walking-skeleton version. The full interview/synthesis logic will live in the `synthesizer` skill — for now, run the interview by hand and produce the artifacts inline.
- Do NOT invent features the user didn't ask for. If they said "no auth in v1," the scaffolding has no auth.
- Stack-tune everything. Conventions, file paths, test layout, slash-command templates all reflect the declared stack.
- Prefer assistant-neutral outputs first. Adapter files for a specific assistant are optional, not canonical.
- Keep the first pass small. If a minimal pack is enough to unblock work, stop there.
