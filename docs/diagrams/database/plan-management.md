---
sidebar_position: 4
---

# Plan management

## Correctness

### New table(s)

```mermaid
erDiagram
  plan {
    serial id PK
    int days UK
  }

  plan_history {
    serial id PK
    int planId FK
    timestamptz createdAt
    decimal rate
  }

  plan }o--|| plan_history : "has history"
```

### Full relationships

```mermaid
erDiagram
  user }o--|| source : "has"
  source }o--|| top_up : "has"
  plan }o--|| plan_history : "has history"
```
