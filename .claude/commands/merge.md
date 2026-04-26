---
description: Commit, optionally version-bump and tag, optionally push. No skill behind this — just git/gh.
---

For sloth (declarative markdown, solo dev, no PR review process):

1. Run `git status` and show the user what's staged/unstaged
2. Confirm what to include in the commit
3. Stage and commit with a 1-2 sentence message focused on the *why*
4. Ask: **is this a release?**
   - If yes, ask for version bump (patch / minor / major)
   - Update `version` in `.claude-plugin/plugin.json`
   - Update matching version in `.claude-plugin/marketplace.json`
   - Commit version bump with message `chore: bump to vX.Y.Z`
   - Tag the commit: `git tag vX.Y.Z`
5. **If a remote is configured: ask before pushing.** Never auto-push.

## Hard rules

- Do not bypass git hooks (`--no-verify`).
- Do not skip GPG signing.
- Always create new commits — never amend published ones.
- Never force-push to main.
- Never invent version numbers — bump from the current `plugin.json` value.
