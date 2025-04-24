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

```env
PORT=3001 # Port of Server
UPLOAD_PATH=assets/uploads # For avatar uploading, no trailing /
API_SERVER_URL= # For something, no trailing /

DB_HOST=
DB_USERNAME=
DB_PASSWORD=
DB_DATABASE=
DB_PORT=

AI_API_KEY= # Not yet,...

SUPABASE_PROJECT_URL= # No trailing /
SUPABASE_JWT_SECRET= # For auth user
SUPABASE_SERVICE_ROLE_KEY= # For communicate with supabase server

ADMIN_JWT_SECRET=
ADMIN_JWT_REFRESH_SECRET=

VNPAY_TMN_CODE=
VNPAY_SECURE_SECRET=
VNPAY_HOST=https://sandbox.vnpayment.vn
```

## Dev

- Start Supabase
  ```sh
  just ss
  ```
- Start API server
  ```sh
  just
  ```
