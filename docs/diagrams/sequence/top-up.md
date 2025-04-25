---
sidebar_position: 3
---

# Top up

```mermaid
sequenceDiagram
  autonumber

  actor mobile as Mobile
  participant apiServer as API Server
  participant topupProvider as Trung gian nạp tiền
  participant bank as Ngân hàng

  mobile->>apiServer: Chi tiết thanh toán
  activate mobile
  activate apiServer
  apiServer-->>mobile: URL thanh toán
  deactivate apiServer

  mobile->>topupProvider: Yêu cầu thanh toán
  activate topupProvider
  mobile->>topupProvider: Thông tin tài khoản thanh toán
  topupProvider->>bank: Yêu cầu xác thực
  activate bank
  bank-->>topupProvider: Xác thực thành công
  mobile->>topupProvider: Nhập OTP
  topupProvider->>bank: Xác thực OTP, chuẩn chi GD
  bank-->>topupProvider: Giao dịch thành công
  deactivate bank

  topupProvider->>mobile: Thông báo kết quả GD<br />(Return URL)
  deactivate mobile
  topupProvider->>apiServer: Thông báo kết quả GD<br />(IPN URL)
  activate apiServer
  apiServer-->>topupProvider: Phản hồi kết quả cập nhật
  deactivate apiServer
  deactivate topupProvider
```
