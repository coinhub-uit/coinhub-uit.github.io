---
sidebar_position: 5
---

# Ticket creation

## Correctness

### New table(s)

```mermaid
erDiagram
  ticket {
    serial id PK
    int sourceId FK
    int planId
    enum method
    timestamptz openedAt
    timestamptz closedAt
    enum status
  }

  ticket_history {
    int ticketId PK,FK
    date issuedAt PK
    date maturedAt
    int planHistoryId FK
    decimal principal
    decimal interest
  }

  available_plan {
    int id "planHistoryId"
    decimal rate
    int planId
    int days
  }

  ticket }|--|| ticket_history : "has history"
```

### Full relationships

```mermaid
erDiagram
  available_plan

  user }o--|| source : "has"
  source }o--|| top_up : "has"
  plan }o--|| plan_history : "has history"
  ticket }|--|| ticket_history : "has history"
  ticket ||--|o plan: "has"
  ticket_history ||--}o plan_history : "has latest"
  source }o--|| ticket : "has"
```

## Evolution

### New tables(s)

```mermaid
erDiagram
  settings {
    boolean id PK
    decimal minAmountOpenTicket
  }
```

### Full relationships

```mermaid
erDiagram
  available_plan
  settings

  user }o--|| source : "has"
  source }o--|| top_up : "has"
  plan }o--|| plan_history : "has history"
  ticket }|--|| ticket_history : "has history"
  ticket ||--|o plan: "has"
  ticket_history ||--}o plan_history : "has latest"
  source }o--|| ticket : "has"
```
