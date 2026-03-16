#!/usr/bin/env bash
set -euo pipefail

# Replace these placeholders for the target machine.
WORKSPACE_ROOT="/absolute/path/to/openclaw-workspace"
STATE_DIR="/absolute/path/to/orange-xp-state"
OPENCLAW_RUN_COMMAND='REPLACE_WITH_YOUR_OPENCLAW_COMMAND'

mkdir -p "$STATE_DIR"

export ORANGE_XP_DAY_KEY="$(date -u +%F)"
export ORANGE_XP_STATE_FILE="$STATE_DIR/completions.json"

if [[ "$OPENCLAW_RUN_COMMAND" == 'REPLACE_WITH_YOUR_OPENCLAW_COMMAND' ]]; then
  echo "set OPENCLAW_RUN_COMMAND in $(basename "$0") before using this wrapper" >&2
  exit 1
fi

cd "$WORKSPACE_ROOT"
exec sh -lc "$OPENCLAW_RUN_COMMAND"
