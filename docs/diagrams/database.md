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
    decimal minAmountOpenTicket
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
    char(10) phoneNumber "Nullable"
    timestamp createdAt
    timestamp deletedAt "Nullable"
  }

  source {
    varchar(20) id PK "User choice"
    uuid userId FK
    decimal balance "Default 0, >= 0"
  }

  method {
    varchar(3) id "Seed(NR, PR, PIR)"
  }

  plan_history {
    serial id PK
    int planId FK
    date createdAt
    decimal rate
  }

  ticket {
    serial id PK
    int sourceId FK
    varchar(3) methodId FK
    date openedAt "Default now"
    date closedAt "Nullable, = ticket's end date"
  }

  ticket_history {
    int ticketId PK,FK
    date issueAt PK "ticket[createdAt] || prev[issueAt]"
    date maturityAt "issueDate + plan[days] + 1"
    int planHistoryId FK "plan_history[id] where max(plan_history[createdAt])"
    decimal amount ">= settings[minAmountOpenTicket]"
  }

  plan {
    serial id PK
    int days UK ">= 1, Seed(30, 90, 180)"
    boolean isActive
  }

  notification {
    serial id PK
    uuid userId FK "Index"
    nvarchar title
    text content
    timestamp createdAt "Default now"
    boolean isSeen
  }

  avaiable_plan {
    int id "planHistoryId"
    date createdAt
    decimal rate
    int planId
  }

  top_up {
    uuid id PK "Auto gen"
    text type "vnpay | momo | zalopay"
    varchar(20) sourceDestination FK
    decimal amount
    enum status "success | failed | overdue"
  }

  user }o--|| notification : "has"
  user }o--|| source : "has"
  source }o--|| ticket : "has"
  ticket ||--o{ method : "has"
  ticket }|--|| ticket_history : "has history"
  plan }o--|| plan_history : "has history"
  ticket_history ||--}o plan_history : "has latest"
  source }o--|| top_up : "has"
```

:::note

- `serial` type: It's `int` but auto increase. In other tables ref to the table has `serial` will have `int` type
- `decimal` type:

  - With money, it will be `decimal(12,0)`
  - With rate, it will be `decimal(4,2)`

- Materialized view:

  - `avaiable_plan`: latest,active plan history

:::

## Term explanation

- **Method**:
  - `NR`: Non-rollover
  - `PR`: Principal Rollover
  - `PIR`: Principal & Interest Rollover
