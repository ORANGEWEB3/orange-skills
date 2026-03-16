# orange-skills

Portable OpenClaw skills and instructions for running Orange XP workflows with clear policy gates, daily idempotency rules, and external scheduler examples.

## For Humans

Paste this into your LLM agent:

```text
Install and configure orange-skills by following the instructions here:
<raw-url-to-docs/guide/installation.md>
```

Replace the placeholder with the real raw GitHub URL after publishing. If this repo is only local for now, point the agent at `docs/guide/installation.md` directly.

## For LLM Agents

Read `docs/guide/installation.md` and follow it.

## What This Repo Contains

- `skills/orange-xp-daily-tasks/` - main execution skill for daily or on-demand Orange XP task runs
- `skills/orange-instructions/` - setup and validation instructions for wiring these skills into an OpenClaw workspace
- `scripts/install-skills.sh` - copies the packaged skills into an OpenClaw workspace
- `docs/guide/installation.md` - handoff doc another LLM can follow
- `examples/` - wrapper and scheduler templates for cron, launchd, and systemd

## Important Constraint

These skills do not self-schedule.

To make a workflow run daily, the operator must add an external trigger such as:

- cron
- launchd
- systemd timer
- CI scheduled job

Use the skill to define what the agent should do on each run. Use the scheduler to decide when the run happens.

## Install Into an OpenClaw Workspace

Copy the skills into a workspace that already has OpenClaw configured:

```bash
./scripts/install-skills.sh /path/to/openclaw-workspace
```

After install, the workspace should contain:

```text
workspace/
  skills/
    orange-xp-daily-tasks/
      SKILL.md
      references/
    orange-instructions/
      SKILL.md
      references/
```

## Daily Trigger Pattern

1. Install the skills into the target workspace.
2. Configure operator secrets and any persistent state store.
3. Create a wrapper command that invokes the target OpenClaw run with the `orange-xp-daily-tasks` skill.
4. Schedule that wrapper with cron, launchd, systemd, or another external scheduler.
5. Persist completion state so the agent can skip already-completed tasks for the current UTC day.

## Verification Checklist

- Skills copied into the target workspace
- Scheduler calls a real OpenClaw run command
- Environment contains required auth credentials or token source
- Durable completion log exists outside the transient chat session
- First dry run completes without repeating already-recorded daily tasks

## Files To Edit For A Real Deployment

- `examples/run-orange-xp-daily.sh`
- `examples/cron.example`
- `examples/launchd/com.orange.xp.daily.plist`
- `examples/systemd/orange-xp-daily.service`
- `examples/systemd/orange-xp-daily.timer`

Each example contains placeholders for the actual OpenClaw invocation command and workspace paths.
