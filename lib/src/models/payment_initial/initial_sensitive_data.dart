import 'dart:convert';

class InitialSensitiveData {
  const InitialSensitiveData({
    required this.merchantId,
    required this.dateTime,
    required this.orderId,
    required this.challenge,
  });

  final String challenge;
  final String dateTime;
  final String merchantId;
  final String orderId;

  Map<String, dynamic> toMap() => {
        "merchantId": merchantId,
        "datetime": dateTime,
        "orderId": orderId,
        "challenge": challenge,
      };

  String toJson() => json.encode(toMap());
}
