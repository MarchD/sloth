---
name: synthesizer
description: Shared engine that takes a structured intake (from /start-new interview or /start-existing scan+interview) and produces a project starter brain — CLAUDE.md, ADRs, slash commands, memory seed, optional issues. Stack-tuned. Preview-before-write.
---

# Synthesizer

Shared between `/start-new` (greenfield) and `/start-existing` (brownfield). The two commands differ in *intake* (interview-only vs scan-then-interview); both feed this synthesizer.

## Inputs (structured intake)

Regardless of source, the intake should resolve to:

```
{
  "mode": "greenfield" | "brownfield",
  "vision": { "pitch": "...", "first_user": "...", "core_loop": "...", "success_30d": "...", "non_goals": "..." },
  "stack": { "language": "...", "framework": "...", "experience": "...", "constraints": "..." },
  "workflow": { "team_size": "...", "project_type": "learning" | "shipping", "want_guide": true | false, "issue_tracker": "github" | "linear" | "none" },
  "scan": { "detected_stack": "...", "conventions": {...}, "existing_docs": [...], "existing_claude_md": true | false }   // brownfield only
}
```

## Outputs (the starter brain)

| Artifact | Greenfield | Brownfield |
|----------|------------|------------|
| `CLAUDE.md` | Generated from vision + stack | Descriptive of as-is from scan; diff against existing if present |
| `docs/product/VISION.md` | Generated from vision pass | Skip unless user wants it |
| `docs/decisions/ADR-001` | "Tech stack" — forward decision | "Stack as-is — retroactive snapshot dated <today>" |
| `docs/PROGRESS_TRACKER.md` | Empty board + 3 seeded issues | Skip — issues already exist |
| `.claude/commands/` | Stack-tuned templates | Stack-tuned templates, diff against existing |
| `MEMORY.md` | Empty index | Empty index — never fabricate prior memories |

## Preview-before-write protocol

1. Build the full artifact set in memory.
2. Present a summary list to the user: file path + 1-line description of what's in it.
3. Offer: accept all, edit specific, reject specific.
4. Write only what's accepted. Diff (not overwrite) any pre-existing file.

## Stack-tuning rules

- File naming: detect/declare `snake_case`, `kebab-case`, `camelCase` and apply to all generated templates.
- Test location: detect/declare (`tests/`, `__tests__/`, `src/test/java/`, etc.) and put `/implement` test scaffolds there.
- Build/test commands: bake into CLAUDE.md "Commands" section.
- Conventions in `/implement` template: import style, error handling pattern, logging library if visible.

## Hard rules

- Never invent history. No fabricated ADRs, no fake memory entries, no claims of past decisions that weren't made.
- Never overwrite an existing file without explicit user confirmation. Always offer a diff.
- Never generate features the user didn't ask for. Tight scope per intake.

## Status

**Walking skeleton.** This SKILL.md describes the contract. Real synthesis logic (templates, diff rendering, intake schema validation) will be filled in iteratively. For now, both `/start-new` and `/start-existing` run synthesis inline; this skill exists so the contract is named and the migration path is clear.
