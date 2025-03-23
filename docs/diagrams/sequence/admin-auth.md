---
sidebar_position: 2
---

# Admin authentication

```mermaid
sequenceDiagram
  autonumber
  actor mobile as Mobile
  participant apiServer as API Server
  participant database as Database

  mobile->>apiServer: Thông tin tài khoản
  activate mobile
  activate apiServer
  apiServer->>database: Dữ liệu tài khoản
  activate apiServer
  activate database
  database-->>apiServer: Kết quả tài khoản
  deactivate database
  deactivate apiServer
  alt Tìm thấy tài khoản
    apiServer-->>mobile: JWT token
  else Không tìm thấy tài khoản
    apiServer-->>mobile: Không được phép
  end
  deactivate mobile
  deactivate apiServer
```
