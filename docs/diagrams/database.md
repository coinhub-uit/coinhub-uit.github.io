---
sidebar_position: 3
---

# Database

```mermaid
erDiagram
  statistic {
    date date
    int users "Σ user"
    int tickets
    money deposits "Σ ticket[initMoney]"
  }

  settings {
    money minimumInitMoney
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
    serial id PK "Auto inc"
    int planId FK
    date definedDate
    decimal rate
  }

  ticket {
    serial id PK
    int sourceId FK
    varchar(3) methodId FK
    money initMoney ">= settings[minimumInitMoney] when insert"
    date createdAt "Default now"
    date closedDate "Nullable, defined later"
  }

  ticket_plan_history {
    serial ticketId PK,FK
    int planHistoryId FK
    date issueDate PK "= ticket[createdAt] + 1 || prev[issueDate] + 1"
    date maturityDate "= issueDate + plan[days]"
  }

  plan {
    serial id PK "Auto inc"
    int days UK ">= -1, Seed(-1, 90, 180)"
    boolean isActive
  }

  avaiable_plan {
    serial planHistoryId FK
  }

  notification {
    serial id PK
    uuid userId FK "Index"
    nvarchar title
    text content
    timestamp createdAt "Default now"
    boolean isSeen
  }

  user }o--|| notification : "has"
  user }|--|| source : "has"
  source }o--|| ticket : "has"
  ticket ||--o{ method : "has"
  ticket }|--|| ticket_plan_history : "has sequential"
  plan }o--|| plan_history : "has history"
  ticket_plan_history ||--}o plan_history : "has latest"
```

:::note

- Materialized view:
  - `avaiable_plan`: latest,active plan history

:::

## Term explanation

- **Method**:
  - `NR`: Non-rollover
  - `PR`: Principal Rollover
  - `PIR`: Principal & Interest Rollover
