---
sidebar_position: 1
---

# Payment

## Diagram

```mermaid
sequenceDiagram
  actor mobile
  activate mobile

  mobile->>api_server: Chi tiết thanh toán
  activate api_server
  api_server-->>mobile: URL thanh toán
  deactivate api_server

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

  vnpay->>mobile: Thông báo kết quả GD (Return URL)
  deactivate mobile
  vnpay->>api_server: Thông báo kết quả GD (IPN URL)
  activate api_server
  api_server-->>vnpay: Phản hồi kết quả cập nhật
  deactivate api_server
  deactivate vnpay
```

## Explanations

If have time
