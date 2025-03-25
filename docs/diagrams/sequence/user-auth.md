---
sidebar_position: 1
---

# User authentication

## Credentials

```mermaid
sequenceDiagram
  autonumber
  actor mobile as Mobile
  participant authServer as Authentication Server

  mobile->>authServer: Gửi thông tin tài khoản
  activate mobile
  activate authServer
  alt Tìm thấy tài khoản
    authServer-->>mobile: Trả về Token
  else Không tìm thấy tài khoản
    authServer-->>mobile: Hong tìm thấy gì hết chơn
  end
  deactivate mobile
  deactivate authServer
```

## OAuth

```mermaid
sequenceDiagram
  autonumber
  actor mobile as Mobile
  participant OAuthProvider as OAuth Provider
  participant authServer as Authentication Server

  mobile->>OAuthProvider: Yêu cầu đăng nhập
  activate mobile
  activate OAuthProvider
  OAuthProvider-->>mobile: Trả về Redirect URL đến trang đăng nhập
  mobile->>OAuthProvider: Thông tin đăng nhập
  OAuthProvider-->>OAuthProvider: Xác thực
  OAuthProvider-->>mobile: Authorization Code
  mobile->>authServer: Authorization Code
  activate mobile
  activate authServer
  authServer-->>mobile: Token
  deactivate mobile
  deactivate authServer
  OAuthProvider-->>mobile: Return URL
  deactivate mobile
  deactivate OAuthProvider

```
