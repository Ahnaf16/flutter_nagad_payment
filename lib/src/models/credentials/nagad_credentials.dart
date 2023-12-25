class NagadCredentials {
  const NagadCredentials({
    required this.publicKey,
    required this.privateKey,
    required this.merchantId,
    required this.merchantNumber,
    required this.isSandbox,
  });

  final bool isSandbox;
  final String merchantId;
  final String merchantNumber;
  final String privateKey;
  final String publicKey;
}
