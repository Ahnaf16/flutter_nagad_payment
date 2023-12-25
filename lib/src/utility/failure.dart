import 'package:fpdart/fpdart.dart';

typedef FailEither<T> = Either<Failure, T>;

class Failure {
  const Failure(this.message,
      {this.error, this.code = 0, this.type, this.stackTrace});

  factory Failure.exception(Exception exception, [StackTrace? stackTrace]) {
    return Failure(
      exception.toString(),
      error: exception,
      stackTrace: stackTrace,
    );
  }

  final String message;
  final String? type;
  final int code;
  final Object? error;
  final StackTrace? stackTrace;

  @override
  String toString() {
    return '''
  [Failure ${type ?? ''}] [$code]-------------
   | message: $message
   |
   | error: $error
   |------------------------------------------
''';
  }

  Failure copyWith({
    String? message,
    String? error,
    StackTrace? stackTrace,
  }) {
    return Failure(
      message ?? this.message,
      stackTrace: stackTrace ?? this.stackTrace,
      error: error ?? this.error,
    );
  }
}
