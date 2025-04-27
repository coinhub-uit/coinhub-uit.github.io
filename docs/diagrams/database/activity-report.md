---
sidebar_position: 7
---

# Activity report

## Correctness

### New table(s)

```mermaid
erDiagram
  activity_report {
    date date
    int users
    int tickets
    decimal totalPrincipal
  }
```

### Full relationships

```mermaid
erDiagram
  avaiable_plan
  settings
  activity_report

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
