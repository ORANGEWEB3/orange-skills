---
name: orange-auth-cli
description: Authenticate with Bedrock and call protected Orange project endpoints using the `orange-auth` CLI or MCP tools from `@orangeweb3/mcp-orange-api`. Use when an operator needs reusable Orange auth, MCP server setup, project listing/creation/update commands, liked-project reads, or a token-based alternative to browser automation.
---

# Orange Auth CLI

## Goal

Authenticate safely, then call supported Orange auth and project endpoints with reproducible CLI or MCP flows.

## Required Inputs

- `ORANGE_EMAIL`
- `ORANGE_PASSWORD`

## Optional Inputs

- `BEDROCK_SUBSCRIPTION_KEY` or `OCP_APIM_SUBSCRIPTION_KEY`
- `BEDROCK_AUTH_DEFAULT_TENANT_ID`
- `ORANGE_API_BASE`
- explicit `accessToken` when the caller does not want persisted session state

## Workflow

1. Install or invoke `@orangeweb3/mcp-orange-api`.
2. Authenticate with `orange-auth auth login`.
3. Verify session with `orange-auth auth whoami`.
4. Use project CLI commands or MCP tools.
5. Reuse the persisted session or explicit access token.
6. Logout only when cleanup is needed.

## Rules

- Prefer token-based CLI or MCP access over browser automation.
- Never print raw passwords, access tokens, refresh tokens, or subscription keys.
- Report concise error codes or messages.
- Use persisted session state only when the operator allows it.

## References

- `references/cli-and-mcp.md` - install commands, MCP config, common CLI flows, and tool names
