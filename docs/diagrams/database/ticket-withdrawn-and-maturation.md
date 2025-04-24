---
sidebar_position: 6
---

# Ticket withdrawn and maturation

::: note

I don't think maturation is a right word to describe what I want...?

:::

## Correctness

### New table(s)

```
erDiagram
  notification {
    serial id PK
    uuid userId FK
    nvarchar title
    text content
    timestamptz createdAt
    boolean isRead
  }
```
### Full relationships

```mermaid
erDiagram
  avaiable_plan
  settings

  user }o--|| source : "has"
  user }o--|| notification : "has"
  source }o--|| top_up : "has"
  plan }o--|| plan_history : "has history"
  ticket }|--|| ticket_history : "has history"
  ticket ||--|o plan: "has"
  ticket_history ||--}o plan_history : "has latest"
  source }o--|| ticket : "has"
```
