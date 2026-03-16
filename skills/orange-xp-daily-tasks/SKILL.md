---
name: orange-xp-daily-tasks
description: Execute Orange XP workflows during a scheduled or on-demand OpenClaw run. Use when an operator wants the agent to perform only platform-permitted Orange tasks, reuse Bedrock auth where supported, prefer token injection over browser automation, enforce once-per-day or once-per-project idempotency, and record completion state outside the transient chat session.
---

# Orange XP Daily Tasks

## Goal

Complete only the Orange tasks that are both:

- allowed by current platform policy
- supported by the available APIs or tools
- eligible for the current UTC day or platform-defined day boundary

## Required Operator Inputs

- a valid Bedrock auth path or reusable Bedrock session token
- any account credentials required for platform-supported login flows
- a durable completion log or state store outside the chat session

## Hard Rules

- Authenticate once per session.
- Reuse the same Bedrock token for project-scoped requests where supported.
- Do not use browser automation when token injection is available.
- Respect rate limits.
- Do not repeat a reward-eligible action more often than allowed.
- Only submit truthful, non-spam, human-meaningful content.
- Only perform social or referral actions when explicitly permitted by Orange policy and destination platform policy.
- Fail closed. If API support, policy permission, or task eligibility is unclear, skip the task and report why.

## Daily Run Workflow

1. Determine the current day key in UTC unless the operator has configured a different platform day boundary.
2. Load the durable completion ledger before acting.
3. Read `references/orange-xp-agent-tasks.yaml` for the current task definitions and idempotency rules.
4. For each task:
   - verify preconditions
   - verify API or tool support exists
   - skip tasks already completed for the current day or current account scope
   - execute only the minimal valid actions needed
   - write completion state immediately after success
5. End with a concise report showing completed, skipped, unsupported, and blocked tasks.

## Completion Ledger Requirements

Store enough data to prevent duplicate daily actions across sessions. At minimum, persist:

- `task_id`
- `account_id` or equivalent scope
- `project_id` when task scope is per project
- `action` when task scope is per action
- `day_key`
- `completed_at`
- `status`

If no durable state is available, do not assume a task is safe to repeat.

## Supported Execution Preference

Use this order unless the operator overrides it:

1. packaged API or MCP tools
2. direct authenticated HTTP requests
3. browser automation only when no supported token-based path exists and policy allows it

## Reporting Format

Return:

- which day boundary was used
- which tasks were attempted
- which tasks were skipped because they were already completed
- which tasks were skipped because support or policy was missing
- any state changes written to the completion ledger

## References

- `references/orange-xp-agent-tasks.yaml` - source task and policy definitions
