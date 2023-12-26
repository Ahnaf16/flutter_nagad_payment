import 'package:flutter_nagad_payment/src/models/models.dart';
import 'package:flutter_nagad_payment/src/utility/network/api_caller.dart';
import 'package:fpdart/fpdart.dart';

import '../utility/utility.dart';

abstract class NagadApi with ApiCaller {
  NagadApi(this.credentials) {
    _baseUrl = credentials.isSandbox
        ? 'http://sandbox.mynagad.com:10080/remote-payment-gateway-1.0/api/dfs'
        : 'https://api.mynagad.com/api/dfs';
  }

  final NagadCredentials credentials;
  final _encrypter = KEncrypter();

  late String _baseUrl;
  String get baseUrl => _baseUrl;

  FailEither<String> decryptData(String encryptedData) =>
      _encrypter.decryptWithPrivateKey(encryptedData, credentials.privateKey);

  FailEither<String> encryptData(String data) =>
      _encrypter.encryptWithPublicKey(data, credentials.publicKey);

  FailEither<bool> verify(String data, String signature) {
    final verified =
        _encrypter.verifySignature(data, signature, credentials.publicKey);

    if (verified) return right(true);
    return left(const Failure('Signature Verification Failed'));
  }
}
