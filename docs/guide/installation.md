# Installation

## For Humans

Paste this into your LLM agent session:

```text
Install and configure orange-skills by following the instructions in this repo's docs/guide/installation.md file.
```

If the agent can access raw GitHub files, give it the raw URL to this document instead.

## For LLM Agents

Follow these steps.

### Step 1: Identify the target OpenClaw workspace

Find the workspace root that should receive the skills.

Requirements:

- the target path exists
- the operator wants these skills in that workspace
- the workspace has or can create a `skills/` directory

### Step 2: Install the skills

From this repo, run:

```bash
./scripts/install-skills.sh /path/to/openclaw-workspace
```

After copying, verify the workspace contains:

```text
skills/
  orange-xp-daily-tasks/
  orange-instructions/
```

### Step 3: Set up durable state

Do not rely on chat history.

Choose a durable completion ledger that survives new sessions, such as:

- a JSON file
- SQLite
- PostgreSQL
- Redis plus durable backup

The ledger should track at least:

- `task_id`
- `account_id`
- `project_id`
- `action`
- `day_key`
- `status`
- `completed_at`

### Step 4: Wire daily triggering

These skills do not self-schedule.

Use one external scheduler:

- cron
- launchd
- systemd timer
- CI scheduled job

Edit `examples/run-orange-xp-daily.sh` so it contains:

- the real OpenClaw workspace path
- the durable state path
- the real OpenClaw invocation command for that machine

Then choose one example from `examples/` and adapt it.

### Step 5: Verify a dry run

Verify all of the following:

- the OpenClaw run command is real, not a placeholder
- the agent can load `orange-xp-daily-tasks`
- the run writes completion state to the durable ledger
- a second run on the same UTC day skips already-completed daily tasks

### Step 6: Explain the guarantee clearly

Tell the operator:

- the skill defines what to do
- the scheduler defines when to run
- the ledger prevents duplicate daily work across sessions

Without all three, the setup is not truly daily.
