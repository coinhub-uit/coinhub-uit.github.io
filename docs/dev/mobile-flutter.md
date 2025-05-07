---
sidebar_position: 2
---

# Mobile Flutter

## Prerequisites

- [Just](https://github.com/casey/just)
- [Flutter](https://flutter.dev/)
- [Firebase CLI](https://firebase.google.com/docs/cli#install_the_firebase_cli)

## Setup

### Bootstrap

```sh
just b
```

### Setup Firebase

#### Login firebase

```sh
firebase login
```

#### Setup files

```sh
just sf '<PROJECT_ID>'
```

### Setup `.env`

```env
API_SERVER_URL=
SUPABASE_URL=
SUPABASE_ANON_KEY=
OAUTH_GOOGLE_WEB_CLIENT_ID=
OAUTH_GOOGLE_IOS_CLIENT_ID=
```

## Dev

- VSCode: <kbd>F5</kbd> to debug
- CLI:
  ```sh
  just
  ```
