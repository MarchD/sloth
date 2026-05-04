<p align="center">
  <img src="sloth.png" alt="sloth" width="120" />
</p>

# sloth

> The lazy starter brain for agent-assisted software projects.

Skip the boring setup. Answer some questions, or let sloth run a compact repo scan, and get a working `AGENTS.md` plus the smallest workflow pack needed to move forward.

## Two modes

### `/start-new` — for a brand new idea
Interview-only. Sloth asks ~10 questions about your idea, stack, and how you want to work. Then generates the starter brain so day 1 of the project does not start from an empty `AGENTS.md`.

### `/start-existing` — for a repo you already have
Scan-then-interview. Sloth should first produce a compact machine summary of the repo, ask only the questions that summary cannot answer, then generate the minimum useful output for understand -> plan -> implement -> sync -> merge. **Never invents history.**

### `/refresh-existing` — for a repo Sloth already touched
Incremental refresh. Sloth reads the existing brain, runs a compact rescan, detects drift, and proposes minimal diffs instead of rerunning onboarding.

## Design principles

1. **Lazy-first.** Setup should take 15 minutes, not 15 hours.
2. **Honest provenance.** No fabricated ADRs, no fake memory entries, no claims about past decisions that didn't happen.
3. **Preview before write.** You see every artifact before sloth touches your filesystem.
4. **Stack-tuned.** Generated templates respect your conventions (snake_case vs camelCase, where tests live, your build tool).
5. **Tight scope.** Sloth generates what you asked for, not what it thinks you should have.
6. **Agent-agnostic core.** The generated project brain is neutral (`AGENTS.md`, `.agents/commands/`), with assistant-specific adapters treated as optional wrappers.
7. **Token-aware by default.** Prefer deterministic local scans, compact persisted state, and incremental updates over rereading the repo or regenerating everything.

## Status

🦥 **Walking skeleton (v0.1.0).** Current distribution is still a Claude-compatible plugin manifest, but the product contract is moving to an agent-agnostic core. Interview and synthesis logic still run inline for now; the synthesizer will harden as the workflow gets validated on real projects.

## Install

```
/plugin marketplace add MarchD/sloth
/plugin install sloth@sloth-marketplace
```

For local development (no GitHub round-trip):

```
/plugin marketplace add /path/to/sloth
/plugin install sloth@sloth-marketplace
```

## Structure

```
sloth/
├── .Codex/
│   └── commands/
├── adapters/
│   ├── claude/
│   └── codex/
├── .claude-plugin/           # current packaging adapter
│   ├── plugin.json
│   └── marketplace.json
├── commands/                 # ships to plugin users
│   ├── start-new.md
│   ├── start-existing.md
│   └── refresh-existing.md
├── skills/                   # ships to plugin users
│   └── synthesizer/
│       └── SKILL.md
├── .agents/                  # sloth's own neutral dev workflow
│   ├── commands/
│   └── skills/
├── .claude/                  # legacy adapter for Claude-oriented local workflow
│   ├── commands/
│   └── skills/
├── templates/                # stack-tuned templates (filled in iteratively)
├── sloth.png
└── README.md
```

## Architecture Split

Sloth now has three layers:

- **Core**: neutral contract for intake, synthesis, refresh, and generated outputs
- **Host adapters**: assistant-specific packaging such as `.claude-plugin/`
- **Generated outputs**: what gets written into the user's project

The new adapter directory lives at [adapters/README.md](/Users/marynadubchak/Documents/projects-to-launch/sloth/adapters/README.md:1).
The shared adapter checklist lives at [docs/ADAPTER_CONTRACT.md](/Users/marynadubchak/Documents/projects-to-launch/sloth/docs/ADAPTER_CONTRACT.md:1).

Current Codex-facing wrappers live in `.Codex/commands/` and are installable into another project via [adapters/codex/INSTALL.md](/Users/marynadubchak/Documents/projects-to-launch/sloth/adapters/codex/INSTALL.md:1).
The current Codex decision is documented in [docs/decisions/ADR-002-codex-adapter-surface.md](/Users/marynadubchak/Documents/projects-to-launch/sloth/docs/decisions/ADR-002-codex-adapter-surface.md:1).

The canonical split is documented in [docs/ARCHITECTURE.md](/Users/marynadubchak/Documents/projects-to-launch/sloth/docs/ARCHITECTURE.md:1).

## Output model

Sloth's target output is an assistant-neutral project brain:

- `AGENTS.md` — durable project context, commands, conventions, and open questions
- `docs/WORKFLOW.md` — how work moves from understanding to planning to implementation to merge
- `docs/PRINCIPLES.md` — durable rules and non-negotiables
- `docs/decisions/ADR-001-*.md` — honest architecture snapshot or decision
- `.agents/commands/` — repo-tuned rituals such as `/understand`, `/plan`, `/implement`, `/guide`, `/sync`, `/merge`

If a team wants assistant-specific files like `CLAUDE.md`, they should be derived adapters, not the canonical source of truth.

## Low-token model

For existing repos, Sloth should avoid a full conversational scan on every run:

- Run a deterministic local scan and save a compact summary such as `.sloth/scan-summary.json`
- Reuse persisted intake instead of rescanning unchanged context
- Ask only unresolved questions
- Default to minimal output: `AGENTS.md`, `docs/WORKFLOW.md`, and `.agents/commands/`
- Make ADRs, principles, and assistant-specific adapters opt-in unless needed

For refreshed repos, Sloth should:

- load `.sloth/scan-summary.json`, `.sloth/intake.json`, and `.sloth/brain-state.json` if present
- compare current repo state to the last known scan
- patch only stale sections instead of regenerating whole files
- preserve handwritten content unless the user explicitly wants replacement
