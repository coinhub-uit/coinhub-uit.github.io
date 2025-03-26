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
    money deposits "Σ ticket[amount]"
  }

  settings {
    money minAmountOpenTicket
  }

  admin {
    nvarchar username PK,UK
    text password "Hashed"
  }

  user {
    uuid id PK "Supabase generated"
    varchar(20) userName UK "Index"
    nvarchar fullName
    char(12) citizenId
    date birthDay
    text pin "Hashed"
    bytea avatar "Optional, fallback OAuth image"
    text address "Optional"
    text email "Optional"
    char(10) phoneNumber "Optional"
    datetime createAt
  }

  source {
    varchar(20) id PK "User choice"
    uuid userId FK
    money balance "Default 0, >= 0"
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
    money amount ">= settings[minAmountOpenTicket]"
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

  user }o--|| notification : "has"
  user }|--|| source : "has"
  source }o--|| ticket : "has"
  ticket ||--o{ method : "has"
  ticket }|--|| ticket_history : "has sequential"
  plan }o--|| plan_history : "has history"
  ticket_history ||--}o plan_history : "has latest"
```

:::note

- `serial` type: It's `int` but auto increase. In other tables ref to the table has `serial` will have `int` type

- Materialized view:

  - `avaiable_plan`: latest,active plan history

:::

## Term explanation

- **Method**:
  - `NR`: Non-rollover
  - `PR`: Principal Rollover
  - `PIR`: Principal & Interest Rollover
