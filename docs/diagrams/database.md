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
    text userName UK "Index"
    nvarchar fullName
    char(12) citizenId
    date birthDay
    text pin "Hashed"
    bytea avatar "Optional, fallback OAuth image"
    text address "Optional"
    char(10) phoneNumber "Optional"
    timestamp createAt
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
    date definedDate
    decimal rate
  }

  ticket {
    serial id PK
    int sourceId FK
    varchar(3) methodId FK
    date openedDate "Default now"
    date closedDate "Nullable, defined later"
  }

  ticket_history {
    int ticketId PK,FK
    date issueDate PK "ticket[createdAt] + 1 || prev[issueDate] + 1"
    date maturityDate "issueDate + plan[days]"
    int planHistoryId FK "plan_history[id] where max(plan_history[definedDate])"
    decimal amount ">= settings[minAmountOpenTicket]"
  }

  plan {
    serial id PK
    int days UK ">= -1, Seed(30, 90, 180)"
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
    date definedDate
    decimal rate
    int planId
  }

  top_up {
    uuid id PK "Auto gen"
    enum type "VNPAY | MOMO | ZALOPAY"
    varchar(20) sourceDestination FK
    decimal amount
    boolean isPaid "Default false"
  }

  user }o--|| notification : "has"
  user }|--|| source : "has"
  source }o--|| ticket : "has"
  ticket ||--o{ method : "has"
  ticket }|--|| ticket_history : "has sequential"
  plan }o--|| plan_history : "has history"
  ticket_history ||--}o plan_history : "has latest"
  source }o--|| top_up : "has"
```

:::note

- `serial` type: It's `int` but auto increase. In other tables ref to the table has `serial` will have `int` type
- `decimal` type:

  - With money, it will be `decimal(12,0)`
  - With rate, it will be `decimal(3,1)`

- Materialized view:

  - `avaiable_plan`: latest,active plan history

:::

## Term explanation

- **Method**:
  - `NR`: Non-rollover
  - `PR`: Principal Rollover
  - `PIR`: Principal & Interest Rollover
