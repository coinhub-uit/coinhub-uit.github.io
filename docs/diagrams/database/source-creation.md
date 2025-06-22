---
sidebar_position: 2
---

# Source creation

## Correctness

### New table(s)

```mermaid
erDiagram
  source {
    varchar(20) id PK
    uuid userId FK
    decimal balance
    openedAt timestamptz
    closedAt timestamptz
  }
```

### Full relationships

```mermaid
erDiagram
  user }o--|| source : "has"
```
