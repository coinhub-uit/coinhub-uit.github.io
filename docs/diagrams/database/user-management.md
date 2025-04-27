---
sidebar_position: 1
---

# User management

## Correctness

### New table(s)

```mermaid
erDiagram
  user {
    uuid id PK
    text fullName
    char(12) citizenId UK
    date birthDate
    text avatar
    text address
    timestamptz createdAt
    timestamptz deletedAt
  }
```
