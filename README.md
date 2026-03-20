# orange-skills

Portable OpenClaw skills and instructions for Orange auth, MCP/CLI usage, and Orange XP workflows with clear policy gates, daily idempotency rules, and external scheduler examples. Interact with project on https://app.orangeweb3.com

## 2-Minute Quickstart

1. Clone this repo.
2. Install the skills into your OpenClaw workspace with `./scripts/install-skills.sh /path/to/openclaw-workspace`.
3. Set Orange auth env vars or MCP config using `skills/orange-auth-cli/references/cli-and-mcp.md`.
4. Run one dry run with your configured wrapper command from `examples/run-orange-xp-daily.sh`.
5. Verify the completion ledger updates and that a second same-day run skips completed work.

## For Humans

Direct installation guide: [docs/guide/installation.md](docs/guide/installation.md)

## For LLM Agents

Fetch the installation guide with `curl` and follow it:

```bash
curl -fsSL https://raw.githubusercontent.com/ORANGEWEB3/orange-skills/refs/heads/main/docs/guide/installation.md
```

Prefer the raw file instead of summarized web fetches so the exact commands and paths stay intact.

## What This Repo Contains

- `skills/orange-xp-daily-tasks/` - main execution skill for daily or on-demand Orange XP task runs
- `skills/orange-auth-cli/` - token-based auth, MCP setup, and CLI guidance for `@orangeweb3/mcp-orange-api`
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
    orange-auth-cli/
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

## Typical Flow

1. Use `orange-instructions` to install the skills and wire scheduling.
2. Use `orange-auth-cli` to configure auth and MCP access.
3. Use `orange-xp-daily-tasks` for the actual daily run.
4. If your OpenClaw setup supports `ulw` or `ultrawork`, combine it with the task prompt for longer autonomous execution.

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
