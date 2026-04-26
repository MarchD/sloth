<p align="center">
  <img src="sloth.png" alt="sloth" width="120" />
</p>

# sloth

> The lazy starter brain for Claude Code projects.

Skip the boring setup. Answer some questions (or let sloth scan your repo), get a working `CLAUDE.md`, ADR-001, slash commands, and memory seed — so you can start building instead of scaffolding.

## Two modes

### `/start-new` — for a brand new idea
Interview-only. Sloth asks ~10 questions about your idea, stack, and how you want to work. Then generates the starter brain so day 1 of the project doesn't start from an empty `CLAUDE.md`.

### `/start-existing` — for a repo you already have
Scan-then-interview. Sloth reads your repo first, shows you what it found, asks you to confirm/correct, then asks ~5 forward-looking questions. Generates a *descriptive* (not aspirational) `CLAUDE.md`, a retroactive ADR snapshot, and stack-tuned slash commands. **Never invents history.**

## Design principles

1. **Lazy-first.** Setup should take 15 minutes, not 15 hours.
2. **Honest provenance.** No fabricated ADRs, no fake memory entries, no claims about past decisions that didn't happen.
3. **Preview before write.** You see every artifact before sloth touches your filesystem.
4. **Stack-tuned.** Generated templates respect your conventions (snake_case vs camelCase, where tests live, your build tool).
5. **Tight scope.** Sloth generates what you asked for, not what it thinks you should have.

## Status

🦥 **Walking skeleton (v0.1.0).** Plugin manifest + two slash commands + synthesizer skill stub. Interview/synthesis logic runs inline for now; the synthesizer will harden as the workflow gets validated by hand on real projects.

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
├── .claude-plugin/
│   ├── plugin.json
│   └── marketplace.json
├── commands/                 # ships to plugin users
│   ├── start-new.md
│   └── start-existing.md
├── skills/                   # ships to plugin users
│   └── synthesizer/
│       └── SKILL.md
├── .claude/                  # sloth's own dev workflow (commands + skills)
│   ├── commands/
│   └── skills/
├── templates/                # stack-tuned templates (filled in iteratively)
├── sloth.png
└── README.md
```
