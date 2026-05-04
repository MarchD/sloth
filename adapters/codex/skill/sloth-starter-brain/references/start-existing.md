## Goal

Take a project that already has code, conventions, and history, and retrofit an understand -> plan -> implement -> guide -> sync -> merge workflow onto it without burning tokens on repeated full-repo synthesis.

## Flow

### 1. Compact scan pass

Build an honest as-is picture with the smallest deterministic scan possible. Prefer shell commands and compact structured output over pasting file contents into the conversation.

- Build files
- Top-level directory structure
- Short README summary only if needed
- Existing docs by filename
- CI files
- `git log --oneline -10`
- Existing `AGENTS.md`, `CLAUDE.md`, `.agents/`, and `.claude/`

Write the scan result to compact persisted state when possible, for example `.sloth/scan-summary.json`.

Output a compact summary covering:

- stack
- structure
- testing setup
- CI status
- recent activity
- existing agent tooling
- likely workflow pain points

Do not inline large file contents unless the scan leaves a critical ambiguity.

### 2. Confirm and correct

Show the summary and ask the user to correct only what matters.

### 3. Forward pass

- What's painful right now in your workflow
- What's the next milestone you care about
- Where do you most often lose context today
- Which workflow rituals matter to you

Only ask follow-up questions that the compact scan could not answer.

### 4. Principles pass

- Testing stance
- Security or privacy lines
- One or two "we never X" rules

### 5. Wrap-up

List unresolved ambiguities and carry them into `AGENTS.md`.

## Synthesis

Generate honestly:

- `AGENTS.md`
- `docs/WORKFLOW.md`
- `.agents/commands/` for at least `/understand`, `/plan`, `/implement`, `/sync`, `/merge`
- persisted intake and state

Generate these only if they add clear value:

- `docs/decisions/ADR-001-stack-as-is.md`
- `docs/PRINCIPLES.md`
- assistant-specific adapters
- `MEMORY.md`
