import 'package:flutter_nagad_payment/src/models/models.dart';
import 'package:fpdart/fpdart.dart';

import '../utility/utility.dart';
import 'api.dart';

class InitialPaymentApi extends NagadApi {
  InitialPaymentApi(super.credentials);

  /// Initiate Nagad payment request
  FutureFail<InitialResponse> request() async {
    // post request to nagad api with encrypted data
    final response = await super.post(
      baseUrl,
      body: {},
    );

    // folds the response to either failure or success
    return response.fold(
      (l) => left(l),
      (res) {
        // extracts sensitiveData and signature from response
        final sensitive = res.data['sensitiveData'];
        final signature = res.data['signature'];

        // decrypts sensitive data
        final decrypted = super.decryptData(sensitive);

        // folds the decrypted data to either failure or success
        return decrypted.fold(
          (l) => left(l),
          (r) {
            // verifies signature
            final isSignVerified = super.verify(r, signature);

            // returns failure if signature verification failed
            return isSignVerified.fold(
              (l) => left(l),
              (_) {
                // returns decrypted data as success
                return right(InitialResponse.fromJson(r));
              },
            );
          },
        );
      },
    );
  }
}
