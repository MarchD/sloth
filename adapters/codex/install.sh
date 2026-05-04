#!/bin/sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname "$0")" && pwd)
REPO_ROOT=$(CDPATH= cd -- "$SCRIPT_DIR/../.." && pwd)
CODEX_HOME_DIR=${CODEX_HOME:-"$HOME/.codex"}
TARGET_DIR=${1:-"$CODEX_HOME_DIR/skills"}
SKILL_NAME="sloth-starter-brain"

mkdir -p "$TARGET_DIR"
rm -rf "$TARGET_DIR/$SKILL_NAME"
cp -R "$REPO_ROOT/adapters/codex/skill/$SKILL_NAME" "$TARGET_DIR/$SKILL_NAME"

printf 'Installed Sloth Codex skill into %s/%s\n' "$TARGET_DIR" "$SKILL_NAME"
