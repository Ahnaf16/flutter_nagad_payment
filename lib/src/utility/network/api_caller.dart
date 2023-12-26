import 'dart:io' as io;

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../utility.dart';

mixin ApiCaller {
  final dio = Dio();

  Future<Map<String, String>> headers() async {
    return {
      'Content-Type': 'application/json',
      'X-KM-Api-Version': 'v-0.2.0',
      'X-KM-IP-V4': await _getDeviceIP(),
      'X-KM-Client-Type': 'MOBILE_APP',
    };
  }

  Future<String> _getDeviceIP() async {
    final interfaces = await io.NetworkInterface.list();
    return interfaces.firstOrNull?.addresses.firstOrNull?.address ?? '';
  }

  FutureFail<Response> post(
    String url, {
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await dio.post(
        url,
        data: body,
        options: Options(headers: await headers()),
      );
      return right(response);
    } on DioFailure catch (e) {
      return left(e.toFailure());
    }
  }
}
