import 'package:flutter_nagad_payment/src/models/models.dart';

abstract class NagadApi {
  NagadApi(this.credentials);

  final String baseUrl = "https://api.flutterwave.com/v3/";
  final NagadCredentials credentials;
}

class InitialPaymentApi extends NagadApi {
  InitialPaymentApi(super.credentials);
}
