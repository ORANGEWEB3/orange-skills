# Orange Auth CLI and MCP Reference

## Package

- npm: `https://www.npmjs.com/package/@orangeweb3/mcp-orange-api`
- package name: `@orangeweb3/mcp-orange-api`

## Install

### Global install

```bash
npm install -g @orangeweb3/mcp-orange-api
```

This provides:

- `orange-mcp`
- `orange-auth`

### One-off CLI use

```bash
npx -y -p @orangeweb3/mcp-orange-api orange-auth --help
```

## Common CLI Usage

### Authenticate

```bash
npx -y -p @orangeweb3/mcp-orange-api orange-auth auth login \
  --email "${ORANGE_EMAIL}" \
  --password "${ORANGE_PASSWORD}" \
  --json
```

Optional override example:

```bash
npx -y -p @orangeweb3/mcp-orange-api orange-auth auth login \
  --email "${ORANGE_EMAIL}" \
  --password "${ORANGE_PASSWORD}" \
  --tenant-id "${BEDROCK_AUTH_DEFAULT_TENANT_ID:-orangeid-vFlBDiUkSj}" \
  --subscription-key "${BEDROCK_SUBSCRIPTION_KEY}" \
  --json
```

### Verify session

```bash
npx -y -p @orangeweb3/mcp-orange-api orange-auth auth whoami --json
```

### Refresh session

```bash
npx -y -p @orangeweb3/mcp-orange-api orange-auth auth refresh --json
```

### Discover packaged help

```bash
npx -y -p @orangeweb3/mcp-orange-api orange-auth skills
```

### Project commands

```bash
# List authenticated user's projects
ORANGE_API_BASE="${ORANGE_API_BASE}" \
npx -y -p @orangeweb3/mcp-orange-api orange-auth project list-user \
  --project-status approved \
  --search "demo" \
  --ai-tool "chatgpt" \
  --json

# Create project
ORANGE_API_BASE="${ORANGE_API_BASE}" \
npx -y -p @orangeweb3/mcp-orange-api orange-auth project create \
  --payload-file ./project-payload.json \
  --json

# Update project
ORANGE_API_BASE="${ORANGE_API_BASE}" \
npx -y -p @orangeweb3/mcp-orange-api orange-auth project update \
  --project-id "<project-id>" \
  --payload-file ./project-payload.json \
  --json

# Liked projects by Orange ID
ORANGE_API_BASE="${ORANGE_API_BASE}" \
npx -y -p @orangeweb3/mcp-orange-api orange-auth project liked \
  --orange-id "<orange-id>" \
  --json
```

### Logout

```bash
npx -y -p @orangeweb3/mcp-orange-api orange-auth auth logout --json
```

## MCP Tools

### Auth tools

- `auth_register_email`
- `auth_login_email`
- `auth_refresh`
- `auth_whoami`
- `auth_logout`
- `list_skills`

### Project tools

- `list_projects`
- `get_project`
- `list_user_projects`
- `create_project`
- `update_project`
- `list_liked_projects_by_orange_id`
- `submit_feedback`
- `check_rate_limit`
- `get_job_status`

Auth behavior for project tools:

- provide `accessToken` explicitly, or
- call `auth_login_email` first in the same MCP session and omit `accessToken`

## OpenClaw MCP Config Example

Add to the OpenClaw config file used by the target machine:

```jsonc
{
  "mcpServers": {
    "orange-web3": {
      "command": "npx",
      "args": ["-y", "-p", "@orangeweb3/mcp-orange-api", "orange-mcp"],
      "env": {
        "ORANGE_API_BASE": "https://app.orangeweb3.com/api",
        "BEDROCK_AUTH_BASE_URL": "https://api.bedrockpassport.com/api/v1/auth"
      }
    }
  }
}
```

## Environment Variables

- `ORANGE_API_BASE`
- `WORKER_API_BASE`
- `BEDROCK_AUTH_BASE_URL`
- `BEDROCK_SUBSCRIPTION_KEY` or `OCP_APIM_SUBSCRIPTION_KEY`
- `BEDROCK_AUTH_DEFAULT_TENANT_ID`
- `BEDROCK_AUTH_TIMEOUT_MS`

## Notes

- `orange-auth` persists session state by default.
- project commands use `--access-token` first and fall back to persisted session unless `--no-persist` is set.
- some API hosts validate `goal` as a strict enum in project payloads.
