---
sidebar_position: 1
---

# Server

## Prerequisites

- [Just](https://github.com/casey/just)
- [Node](https://nodejs.org/en)
- [Docker](https://www.docker.com/)
- [Supabase](https://supabase.com/docs/guides/local-development)

## Setup

### Bootstrap

```sh
just b
```

### Setup `.env`

See `.env.example`

## Dev

### Run

- Start Supabase
  ```sh
  just ss
  ```
- Start docker compose stuff (include redis)
  ```sh
  just d
  ```
- Start API server
  ```sh
  just
  ```

:::info

See `justfile` for more commands for seeding, resetting database.

:::

### Prompt

#### `codecompanion`

1. Workspace `Generate Active Tickets`

```
@mcp generate ${x} tickets for source with the ID ${y}. Current datetime is /now
```

:::note

You have to manually enter tool (`@mcp`, ...) and function (`/now`, ...) for codecompanion to parse.

:::
