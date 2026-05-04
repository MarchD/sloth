## Goal

Walk the user through a short, structured interview about their product idea. Then synthesize the answers into a starter brain that gives the project a working `AGENTS.md`, `docs/WORKFLOW.md`, a vision doc, and repo-tuned commands.

## Flow

Run these passes in order, one question at a time. Do not generate anything until the user confirms the proposed structure.

### 1. Vision pass
- One-line pitch
- First user
- Core loop
- Success in 30 days
- Explicit non-goals

### 2. Tech pass
- Preferred language or stack and experience level
- Hosting target
- Hard constraints

### 3. Workflow pass
- Solo or team
- Learning project or shipping project
- `/guide` ritual or skip
- Lightweight `/plan` before `/implement`, or direct implementation from issues

### 4. Principles pass
- Testing stance
- Security or privacy lines
- One or two "we never X" rules

### 5. Wrap-up

List unresolved ambiguities. Ask whether to resolve them now or carry them as known unknowns in `AGENTS.md`.

## Synthesis

Show the proposed structure before writing any files. Bundle the minimum useful set first:

- `AGENTS.md`
- `docs/WORKFLOW.md`
- `docs/product/VISION.md`
- `.agents/commands/` for at least `/plan`, `/implement`, `/sync`, `/merge`

Offer these as optional expansions:

- `docs/PRINCIPLES.md`
- `docs/decisions/ADR-001-tech-stack.md`
- `docs/PROGRESS_TRACKER.md`
- assistant-specific adapters only if the user explicitly asks
- `MEMORY.md`
