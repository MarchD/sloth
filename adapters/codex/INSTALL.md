# Codex Install

## Current install surface

The Codex adapter is installed as a Codex skill.

## Install from a cloned Sloth repo

From the Sloth repo:

```sh
sh adapters/codex/install.sh
```

This installs the skill into the default Codex skills directory:

```sh
$HOME/.codex/skills/sloth-starter-brain
```

To install into a different Codex home or skills directory:

```sh
sh adapters/codex/install.sh /custom/skills/dir
```

## What gets installed

- `sloth-starter-brain/SKILL.md`
- `sloth-starter-brain/agents/openai.yaml`
- `sloth-starter-brain/references/start-new.md`
- `sloth-starter-brain/references/start-existing.md`
- `sloth-starter-brain/references/refresh-existing.md`

These files are self-contained and do not depend on absolute paths back to the Sloth repo.

## Updating on another machine

1. Get the updated Sloth repo on that machine.
2. Run the same install script again against the target project.
3. Restart or reopen Codex if the skill does not appear immediately.

## Ready-to-copy remote install prompt

Use this when you want Codex to install Sloth from a remote repository URL:

```text
Clone Sloth from https://github.com/MarchD/sloth, install it as a Codex skill, and verify the install.

Steps:
1. Clone the repository from https://github.com/MarchD/sloth.
2. Enter the cloned `sloth` directory.
3. Run `sh adapters/codex/install.sh`.
4. Verify that `~/.codex/skills/sloth-starter-brain` exists and contains:
   - `SKILL.md`
   - `agents/openai.yaml`
   - `references/start-new.md`
   - `references/start-existing.md`
   - `references/refresh-existing.md`
5. Report whether installation succeeded and include any errors if it failed.

Do not modify the repository unless needed for installation.
```

Short version:

```text
Clone https://github.com/MarchD/sloth, run `sh adapters/codex/install.sh`, verify `~/.codex/skills/sloth-starter-brain` exists, and tell me whether the install succeeded.
```
