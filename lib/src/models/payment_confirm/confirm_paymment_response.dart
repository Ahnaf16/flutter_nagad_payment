import 'dart:convert';

class ConfirmPaymentRequest {
  const ConfirmPaymentRequest({
    required this.callbackURL,
    required this.additionalInfo,
    required this.sensitiveData,
    required this.signature,
  });

  final String callbackURL;
  final Map<String, String> additionalInfo;
  final String sensitiveData;
  final String signature;

  Map<String, dynamic> toMap() => {
        "merchantCallbackURL": callbackURL,
        "additionalMerchantInfo": Map<String, String>.from(additionalInfo),
        "sensitiveData": sensitiveData,
        "signature": signature,
      };

  String toJson() => json.encode(toMap());
}
