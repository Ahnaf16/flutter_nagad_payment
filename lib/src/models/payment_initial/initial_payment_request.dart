import 'dart:convert';

class InitialPaymentRequest {
  const InitialPaymentRequest({
    required this.accountNumber,
    required this.dateTime,
    required this.sensitiveData,
    required this.signature,
  });

  final String accountNumber;
  final String dateTime;
  final String sensitiveData;
  final String signature;

  Map<String, dynamic> toMap() => {
        "accountNumber": accountNumber,
        "dateTime": dateTime,
        "sensitiveData": sensitiveData,
        "signature": signature,
      };

  String toJson() => json.encode(toMap());
}
