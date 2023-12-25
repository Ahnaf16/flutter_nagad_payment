import 'dart:convert';

class NagadConfirmSensitiveData {
  const NagadConfirmSensitiveData({
    required this.merchantId,
    required this.amount,
    required this.orderId,
    required this.challenge,
    this.currencyCode = '050',
  });

  final String currencyCode;
  final String amount;
  final String merchantId;
  final String orderId;
  final String challenge;

  Map<String, dynamic> toMap() => {
        "merchantId": merchantId,
        "amount": amount,
        "orderId": orderId,
        "currencyCode": currencyCode,
        "challenge": challenge,
      };

  String toJson() => json.encode(toMap());
}
