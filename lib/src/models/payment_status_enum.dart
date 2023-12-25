enum PaymentStatus {
  success,
  orderInitiated,
  ready,
  inProgress,
  cancelled,
  invalidRequest,
  fraud,
  aborted,
  unknownFailed;

  factory PaymentStatus.fromName(String name) {
    return switch (name) {
      "Success" => PaymentStatus.success,
      "OrderInitiated" => PaymentStatus.orderInitiated,
      "Ready" => PaymentStatus.ready,
      "InProgress" => PaymentStatus.inProgress,
      "Cancelled" => PaymentStatus.cancelled,
      "InvalidRequest" => PaymentStatus.invalidRequest,
      "Fraud" => PaymentStatus.fraud,
      "Aborted" => PaymentStatus.aborted,
      _ => PaymentStatus.unknownFailed,
    };
  }
}
