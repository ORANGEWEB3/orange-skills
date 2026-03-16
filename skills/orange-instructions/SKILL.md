---
name: orange-instructions
description: Set up the orange-skills bundle inside an OpenClaw workspace. Use when an operator wants help copying the Orange auth and XP skills, setting up MCP or CLI auth access, choosing an external scheduler, and validating that daily runs continue across new sessions.
---

# Orange Instructions

## Goal

Set up `orange-auth-cli` and `orange-xp-daily-tasks` so another OpenClaw workspace can use them reliably.

## Install Workflow

1. Locate the target OpenClaw workspace root.
2. Ensure the workspace has a `skills/` directory.
3. Copy the bundled skill directories into that workspace.
4. Configure Orange auth via CLI or MCP using `orange-auth-cli`.
5. Configure secrets and token sources outside the skill files.
6. Create a durable completion ledger outside the chat session.
7. Add an external daily trigger using cron, launchd, systemd, or equivalent.
8. Run one dry test and verify the run writes completion state.

## Non-Negotiables

- Do not claim a skill is daily unless an external scheduler exists.
- Do not rely on chat history as the completion ledger.
- Do not store secrets directly in `SKILL.md`.
- Prefer copying the entire skill directory so references remain available.

## Expected Destination Layout

```text
<workspace>/skills/
  orange-auth-cli/
    SKILL.md
    references/
  orange-xp-daily-tasks/
    SKILL.md
    references/
  orange-instructions/
    SKILL.md
    references/
```

## Validation Checklist

- target workspace exists
- skills copied successfully
- auth credentials or token source available to the runtime
- durable state file or database path chosen
- scheduler points at a real OpenClaw command
- a new session can still detect already-completed daily work from the durable state store

## References

- `references/setup-checklist.md`
