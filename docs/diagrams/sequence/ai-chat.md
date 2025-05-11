---
sidebar_position: 4
---

# AI chat

```mermaid
sequenceDiagram
  autonumber
  actor mobile as Mobile
  participant apiServer as API Server
  participant aiServer as AI Server

  loop Hỏi
    mobile->>apiServer: Câu hỏi
    activate mobile
    activate apiServer
    apiServer->>aiServer: Cuộc trò chuyện
    activate apiServer
    activate aiServer
    aiServer-->>apiServer: Câu trả lời
    deactivate aiServer
    deactivate apiServer
    apiServer-->>mobile: Câu trả lời
    deactivate apiServer
    deactivate mobile
  end
```
