---
sidebar_position: 3
---

# Database

## User relate

```mermaid
erDiagram
  user {
    uuid id PK "Supabase generated"
    text fullName
    char(12) citizenId UK
    date birthDate
    text avatar "Nullable, URL, fallback OAuth image on client"
    text address "Nullable"
    timestamptz createdAt
    timestamptz deletedAt "Nullable"
  }

  device {
    text id PK
    uuid userId FK
    text fcmToken "For FCM"
  }

  source {
    varchar(20) id PK "User choice"
    uuid userId FK
    decimal balance "Default 0, >= 0"
    openedAt timestamptz
    closedAt timestamptz
  }

  plan {
    serial id PK
    int days UK "\>=1, Seed(-1, 30, 90, 180)"
  }

  plan_history {
    serial id PK
    int planId FK
    timestamptz createdAt
    decimal rate
  }

  ticket {
    serial id PK
    int sourceId FK
    int planId
    enum method "NR | PR | PIR"
    timestamptz openedAt "Default now"
    timestamptz closedAt "Nullable, defined when withdrawn"
    enum status "active | earlyWithdrawn | maturedWithdrawn"
  }

  ticket_history {
    int ticketId PK,FK
    date issuedAt PK "ticket[createdAt] || prev[maturedAt]"
    date maturedAt "issuedAt + plan[days] + 1"
    int planHistoryId FK "plan_history[id] where max(plan_history[createdAt])"
    decimal principal "\>= settings[minPrincipalOpenTicket]"
    decimal interest
  }

  notification {
    serial id PK
    uuid userId FK
    text title
    text content
    timestamptz createdAt "Default now"
    boolean isRead
  }

  available_plan {
    int planHistoryId
    decimal rate
    int planId
    int days
  }

  top_up {
    uuid id PK "Auto gen"
    varchar(20) sourceDestinationId FK
    enum provider "vnpay | momo | zalopay"
    decimal amount
    enum status "processing | success | declined | overdue"
    createAt timestamptz
  }

  user }o--|| notification : "has"
  user }|--|| device : "has"
  user }o--|| source : "has"
  source }o--|| ticket : "has"
  source }o--|| top_up : "has"
  ticket }|--|| ticket_history : "has history"
  ticket ||--|o plan: "has"
  plan }o--|| plan_history : "has history"
  ticket_history ||--}o plan_history : "has latest"
```

:::note

- `serial` type: It's `int` but auto increase. In other tables ref to the table has `serial` will have `int` type
- `decimal` type:

  - With money, it will be `decimal(12,0)`
  - With rate, it will be `decimal(4,2)`

- Materialized view:

  - `available_plan`: latest, active plan history

:::

## Admin relate

```mermaid
erDiagram
  settings {
    boolean id PK "= true"
    decimal minPrincipalOpenTicket
  }

  admin {
    text username PK
    text password "Hashed"
  }
```

## Report relate

```mermaid
erDiagram
  activity_report {
    date date PK
    int users "Σ new user"
    int tickets "Σ ticket hasn't been closed"
    decimal totalPrincipal "Σ ticket_history[principal]"
  }

  revenue_report {
    date date PK
    int days PK "plan[days]"
    decimal income "Σ ticket_history[principal] where ticket_history[issuedAt ~= date]"
    decimal expense "Σ ticket_history[interest] where ticket_history[issuedAt ~= date]"
    decimal netIncome "income - expense"
  }

  ticket_report {
    date date PK
    int days PK "plan[days]"
    int openedCount "Σ ticket_history[issuedAt ~= date]"
    int closedCount "Σ ticket_history[maturedAt ~= date]"
  }
```

## Term explanation

- **Method**:
  - `NR`: Non-rollover
  - `PR`: Principal Rollover
  - `PIR`: Principal & Interest Rollover
