---
name: synthesizer
description: Shared engine that takes a structured intake and produces a minimal project starter brain first, then optional expansions. Stack-tuned. Preview-before-write.
---

# Synthesizer

Shared between `/start-new` (greenfield), `/start-existing` (brownfield bootstrap), and `/refresh-existing` (brownfield incremental refresh). The commands differ in intake, but should converge on the same normalized project brain model.

## Inputs (structured intake)

Regardless of source, the intake should resolve to:

```
{
  "mode": "greenfield" | "brownfield",
  "vision": { "pitch": "...", "first_user": "...", "core_loop": "...", "success_30d": "...", "non_goals": "..." },
  "stack": { "language": "...", "framework": "...", "experience": "...", "constraints": "..." },
  "workflow": { "team_size": "...", "project_type": "learning" | "shipping", "want_guide": true | false, "want_plan": true | false, "issue_tracker": "github" | "linear" | "none", "pain_point": "...", "next_milestone": "..." },
  "principles": { "testing_stance": "...", "security_lines": [...], "never_rules": [...] },
  "open_questions": [ "...", "..." ],   // ambiguities the user chose not to resolve in the interview
  "scan": { "detected_stack": "...", "conventions": {...}, "existing_docs": [...], "existing_agent_files": [...], "existing_claude_md": true | false, "existing_agents_md": true | false, "summary_path": ".sloth/scan-summary.json", "repo_changed_since_summary": true | false }   // brownfield only
  "brain_state": { "canonical_brain_file": "AGENTS.md", "managed_files": [...], "managed_sections": [...], "last_refreshed_at": "..." },   // refresh mode when present
  "refresh_scope": { "core_only": true | false, "include_principles": true | false, "include_adr": true | false, "include_adapters": true | false }   // refresh mode when present
}
```

## Outputs (the starter brain)

| Artifact | Greenfield | Brownfield |
|----------|------------|------------|
| `AGENTS.md` | Default | Default |
| `docs/WORKFLOW.md` | Default | Default |
| `.agents/commands/` | Default | Default |
| `docs/product/VISION.md` | Default | Skip unless user wants it |
| `docs/PRINCIPLES.md` | Optional expansion | Optional expansion |
| `docs/decisions/ADR-001` | Optional expansion | Optional expansion |
| `docs/PROGRESS_TRACKER.md` | Optional expansion | Skip — issues already exist |
| Assistant-specific adapters | Optional only if the user asks | Optional only if the user asks |
| Persisted state (`.sloth/*.json`) | Default | Default |
| `MEMORY.md` | Optional | Optional |

## Refresh mode

When refreshing an existing Sloth-managed project:

1. Load `.sloth/scan-summary.json`, `.sloth/intake.json`, and `.sloth/brain-state.json` if present.
2. Determine the canonical brain file (`AGENTS.md` preferred, `CLAUDE.md` legacy fallback).
3. Detect drift with a compact rescan.
4. Update only stale managed sections or files.
5. Preserve handwritten sections unless the user explicitly opts into replacement.

Refresh should default to:

- `AGENTS.md`
- `docs/WORKFLOW.md`
- `.agents/commands/`
- `.sloth/*.json`

Refresh should treat these as opt-in:

- `docs/PRINCIPLES.md`
- `docs/decisions/ADR-001*`
- assistant-specific adapters
- `MEMORY.md`

## Preview-before-write protocol

1. Build the minimal artifact set first.
2. Present a summary list to the user: file path + 1-line description of what's in it.
3. Offer: accept minimal set, expand specific parts, or reject specific parts.
4. Write only what's accepted. Diff (not overwrite) any pre-existing file.

## Stack-tuning rules

- File naming: detect/declare `snake_case`, `kebab-case`, `camelCase` and apply to all generated templates.
- Test location: detect/declare (`tests/`, `__tests__/`, `src/test/java/`, etc.) and put `/implement` test scaffolds there.
- Build/test commands: bake into `AGENTS.md` and `.agents/commands/`.
- Conventions in `/implement` template: import style, error handling pattern, logging library if visible.
- Brownfield-first tuning: `/understand` should point at the repo surfaces that matter most, and `/plan` should convert the next milestone into a bounded implementation path.
- Prefer scan summaries over raw file contents. Reuse persisted state unless the repo changed materially.

## Hard rules

- Never invent history. No fabricated ADRs, no fake memory entries, no claims of past decisions that weren't made.
- Never overwrite an existing file without explicit user confirmation. Always offer a diff.
- Never generate features the user didn't ask for. Tight scope per intake.
- Never force-resolve ambiguities. If the user did not answer, surface it in `open_questions` and write it through to `AGENTS.md`'s `OPEN_QUESTIONS` section. A known unknown is more honest than an invented answer.
- Tag every principle in `PRINCIPLES.md` as `[observed]` or `[declared]` (brownfield) or `[declared]` (greenfield). Same provenance discipline as ADRs.
- Prefer neutral artifacts. `AGENTS.md` and `.agents/commands/` are canonical; assistant-specific files are adapters.
- Optimize for the next real milestone in brownfield mode. A workflow pack that does not make the next change easier is incomplete.
- Minimize tokens by default. Prefer deterministic local extraction, persisted summaries, and incremental updates over rereading the repo or regenerating optional artifacts.
- In refresh mode, patch sections before patching whole files.

## Status

**Walking skeleton.** This SKILL.md describes the contract. Real synthesis logic (templates, diff rendering, intake schema validation) will be filled in iteratively. For now, both `/start-new` and `/start-existing` run synthesis inline; this skill exists so the contract is named and the migration path is clear.
