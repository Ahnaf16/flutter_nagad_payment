import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nagad_payment/src/utility/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pointycastle/export.dart';

import 'key_parser.dart';

class KEncrypter {
  factory KEncrypter() => _instance;

  KEncrypter._internal();

  static final KEncrypter _instance = KEncrypter._internal();

  FailEither<String> encryptWithPublicKey(String data, String publicKey) {
    try {
      final rsaPublicKey = KeyParser(publicKey).toRASPubicKey();

      final encrypter = PKCS1Encoding(RSAEngine())
        ..init(true, PublicKeyParameter<RSAPublicKey>(rsaPublicKey));

      final Uint8List dataBytes = Uint8List.fromList(utf8.encode(data));
      final Uint8List encryptedBytes = encrypter.process(dataBytes);
      final String encoded = base64.encode(encryptedBytes);

      return right(encoded);
    } on Exception catch (e) {
      return left(Failure.exception(e));
    }
  }

  FailEither<String> decryptWithPrivateKey(
    String encryptedData,
    String privateKey,
  ) {
    try {
      final rsaPrivateKey = KeyParser(privateKey).toRASPrivateKey();

      final decrypter = PKCS1Encoding(RSAEngine())
        ..init(false, PrivateKeyParameter<RSAPrivateKey>(rsaPrivateKey));

      final Uint8List decodedBytes = base64.decode(encryptedData);
      final Uint8List decryptedBytes = decrypter.process(decodedBytes);
      final String decrypted = utf8.decode(decryptedBytes);

      return right(decrypted);
    } on Exception catch (e) {
      return left(Failure.exception(e));
    }
  }

  FailEither<String> signWithKey(String data, String privateKey) {
    try {
      final rsaPrivateKey = KeyParser(privateKey).toRASPrivateKey();

      final sha256Digest = SHA256Digest();
      final signer = RSASigner(sha256Digest, '0609608648016503040201')
        ..init(true, PrivateKeyParameter<RSAPrivateKey>(rsaPrivateKey));

      final Uint8List dataBytes = Uint8List.fromList(utf8.encode(data));
      final Uint8List signature = signer.generateSignature(dataBytes).bytes;
      final String encoded = base64.encode(signature);

      return right(encoded);
    } on Exception catch (e) {
      return left(Failure.exception(e));
    }
  }

  bool verifySignature(String data, String signature, String publicKey) {
    final rsaPublicKey = KeyParser(publicKey).toRASPubicKey();

    final sha256Digest = SHA256Digest();
    final signer = RSASigner(sha256Digest, '0609608648016503040201')
      ..init(false, PublicKeyParameter<RSAPublicKey>(rsaPublicKey));

    final Uint8List dataBytes = Uint8List.fromList(utf8.encode(data));
    final Uint8List signatureBytes = base64.decode(signature);

    return signer.verifySignature(dataBytes, RSASignature(signatureBytes));
  }

  String generateHash(String input, [int max = 40]) {
    final Uint8List data = Uint8List.fromList(utf8.encode(input));

    final Digest sha256Digest = SHA256Digest();
    final Uint8List hashBytes = sha256Digest.process(data);
    final hashString = _bytesToHex(hashBytes);

    return hashString.substring(0, max);
  }

  String _bytesToHex(Uint8List bytes) =>
      bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');
}
