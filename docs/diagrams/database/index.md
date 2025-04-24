---
sidebar_position: 3
---

# Database

```mermaid
erDiagram
  statistic {
    date date
    int users "Σ user"
    int tickets "Σ ticket"
    decimal deposits "Σ ticket[amount]"
  }

  settings {
    boolean id PK "= true"
    decimal minPrincipalOpenTicket
  }

  admin {
    text username PK,UK
    text password "Hashed"
  }

  user {
    uuid id PK "Supabase generated"
    nvarchar fullName
    char(12) citizenId UK
    date birthDate
    text avatar "Nullable, URL, fallback OAuth image on client"
    text address "Nullable"
    timestamptz createdAt
    timestamptz deletedAt "Nullable"
  }

  device {
    uuid userId PK,FK
    text deviceId PK
    text fcmToken "For FCM"
  }

  source {
    varchar(20) id PK "User choice"
    uuid userId FK
    decimal balance "Default 0, >= 0"
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
    uuid userId FK "Index"
    nvarchar title
    text content
    timestamptz createdAt "Default now"
    boolean isRead
  }

  avaiable_plan {
    int id "planHistoryId"
    decimal rate
    int planId
    int days
  }

  top_up {
    uuid id PK "Auto gen"
    varchar(20) sourceDestinationId FK
    text type "vnpay | momo | zalopay"
    decimal amount
    enum status "processing | success | declined | overdue"
    createAt date
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

  - `avaiable_plan`: latest, active plan history

:::

## Term explanation

- **Method**:
  - `NR`: Non-rollover
  - `PR`: Principal Rollover
  - `PIR`: Principal & Interest Rollover
