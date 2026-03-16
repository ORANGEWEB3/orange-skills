# Orange XP Setup Checklist

## Minimum Setup

- Copy both skill directories into the target OpenClaw workspace.
- Keep secrets in environment variables, a secret manager, or another external configuration layer.
- Pick a completion ledger path that survives new OpenClaw sessions.
- Add an external scheduler.

## Completion Ledger Suggestions

Use one of these:

- JSON file on disk
- SQLite database
- PostgreSQL table
- Redis keyspace with a day key plus durable backup

Minimum fields:

- `task_id`
- `account_id`
- `project_id`
- `action`
- `day_key`
- `status`
- `completed_at`

## Scheduler Reminder

The scheduler is what makes the run daily.

The skill only controls what the agent does after the run starts.
