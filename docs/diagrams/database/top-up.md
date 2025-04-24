
---
sidebar_position: 3
---

# Top up

## Correctness

### New table

```mermaid
erDiagram
  top_up {
    uuid id PK
    varchar(20) sourceDestinationId FK
    enum provider
    decimal amount
    enum status
    createdAt timestamptz
  }
```

### Full relationships

```mermaid
erDiagram
  user }o--|| source : "has"
  source }o--|| top_up : "has"
```
