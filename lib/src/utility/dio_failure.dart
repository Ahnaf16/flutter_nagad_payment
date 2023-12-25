import 'dart:io';

import 'package:dio/dio.dart';

import 'utility.dart';

class DioFailure implements Exception {
  DioFailure(this.exception);

  final dynamic exception;

  Failure toFailure() {
    if (exception is DioException) {
      final msg = exception.message ?? '';
      final type = exception.type;
      final code = exception.response?.statusCode ?? 0;

      final onBadRes = type == DioExceptionType.badResponse &&
          exception.response?.data != null;

      if (onBadRes) return _handleBadResponse();

      return Failure(
        msg,
        code: code,
        type: type.name,
        error: exception.response?.data,
        stackTrace: exception.stackTrace,
      );
    }
    if (exception is SocketException) {
      return Failure(
        exception.message.toString(),
        type: 'socket',
        error: exception,
        stackTrace: StackTrace.current,
      );
    }

    return Failure(
      exception.toString(),
      error: exception,
      type: 'unknown',
      stackTrace: StackTrace.current,
    );
  }

  Failure _handleBadResponse() {
    final statusCode = exception.response?.statusCode ?? 0;
    final error = exception.response;

    Failure failure = Failure(
      '',
      code: statusCode,
      type: exception.type.name,
      error: exception.response?.data,
      stackTrace: exception.stackTrace,
    );
    switch (statusCode) {
      case 400:
        failure = failure.copyWith(message: '${error?.statusMessage}');
      case 401:
        failure = failure.copyWith(message: 'Unauthorized');
      case 403:
        failure = failure.copyWith(message: 'Forbidden');
      case 404:
        failure = failure.copyWith(message: 'Not found');
      case 500:
        failure = failure.copyWith(message: 'Internal server error');
      case 502:
        failure = failure.copyWith(message: 'Bad gateway');
      default:
        failure = failure.copyWith(message: '${error?.statusMessage}');
    }

    return failure;
  }
}
