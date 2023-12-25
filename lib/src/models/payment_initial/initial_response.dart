import 'dart:convert';

class InitialResponse {
  InitialResponse({
    required this.referenceId,
    required this.challenge,
    required this.acceptDateTime,
  });

  factory InitialResponse.fromJson(String source) =>
      InitialResponse.fromMap(json.decode(source));

  factory InitialResponse.fromMap(Map<String, dynamic> map) => InitialResponse(
        acceptDateTime: map["acceptDateTime"],
        challenge: map["challenge"],
        referenceId: map["paymentReferenceId"],
      );

  final String acceptDateTime;
  final String challenge;
  final String referenceId;

  Map<String, dynamic> toMap() => {
        "paymentReferenceId": referenceId,
        "challenge": challenge,
        "acceptDateTime": acceptDateTime,
      };

  String toJson() => json.encode(toMap());
}
