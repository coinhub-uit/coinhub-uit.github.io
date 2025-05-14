---
sidebar_position: 10
---

# Requirements changing

## Correctness

### New table(s)

```mermaid
erDiagram
  admin {
    text username PK
    text password
  }
```

### Full relationships

```mermaid
erDiagram
  available_plan
  settings
  activity_report
  revenue_report
  ticket_report
  admin

  user }o--|| source : "has"
  user }|--|| device : "has"
  user }o--|| notification : "has"
  source }o--|| top_up : "has"
  plan }o--|| plan_history : "has history"
  ticket }|--|| ticket_history : "has history"
  ticket ||--|o plan: "has"
  ticket_history ||--}o plan_history : "has latest"
  source }o--|| ticket : "has"
```
