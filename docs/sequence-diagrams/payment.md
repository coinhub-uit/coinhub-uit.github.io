---
sidebar_position: 3
---

# Payment

## VNPAY

```mermaid
sequenceDiagram
  autonumber

  actor mobile as Mobile
  participant apiServer as API Server
  participant vnpay as VNPAY
  participant bank as Ngân hàng

  mobile->>apiServer: Chi tiết thanh toán
  activate mobile
  activate apiServer
  apiServer-->>mobile: URL thanh toán
  deactivate apiServer

  mobile->>vnpay: Yêu cầu thanh toán
  activate vnpay
  mobile->>vnpay: Thông tin tài khoản thanh toán
  vnpay->>bank: Yêu cầu xác thực
  activate bank
  bank-->>vnpay: Xác thực thành công
  mobile->>vnpay: Nhập OTP
  vnpay->>bank: Xác thực OTP, chuẩn chi GD
  bank-->>vnpay: Giao dịch thành công
  deactivate bank

  vnpay->>mobile: Thông báo kết quả GD<br />(Return URL)
  deactivate mobile
  vnpay->>apiServer: Thông báo kết quả GD<br />(IPN URL)
  activate apiServer
  apiServer-->>vnpay: Phản hồi kết quả cập nhật
  deactivate apiServer
  deactivate vnpay
```
