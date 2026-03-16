#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "usage: $0 /path/to/openclaw-workspace" >&2
  exit 1
fi

TARGET_WORKSPACE="$1"
TARGET_SKILLS_DIR="${TARGET_WORKSPACE%/}/skills"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
SOURCE_SKILLS_DIR="${REPO_ROOT}/skills"

if [[ ! -d "$TARGET_WORKSPACE" ]]; then
  echo "workspace does not exist: $TARGET_WORKSPACE" >&2
  exit 1
fi

mkdir -p "$TARGET_SKILLS_DIR"

for skill_dir in "$SOURCE_SKILLS_DIR"/*; do
  skill_name="$(basename "$skill_dir")"
  rm -rf "$TARGET_SKILLS_DIR/$skill_name"
  cp -R "$skill_dir" "$TARGET_SKILLS_DIR/$skill_name"
  echo "installed skill: $skill_name"
done

echo "done: copied skills into $TARGET_SKILLS_DIR"
echo "next: edit the scheduler examples in ${REPO_ROOT}/examples/ and point them at your real OpenClaw run command"
