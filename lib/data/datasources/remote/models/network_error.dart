import 'package:dio/dio.dart';

abstract class NetworkError {
  final dynamic error;
  final StackTrace? stackTrace;
  final Response? response;

  NetworkError({required this.error, required this.stackTrace, this.response});

  factory NetworkError.fromDioException(DioException exception) {
    if (exception.response?.statusCode != null) {
      switch (exception.response!.statusCode) {
        case 400:
          return BadRequest(
              error: exception.error,
              stackTrace: exception.stackTrace,
              response: exception.response!);
        case 401:
          return UnauthorizedError(
              error: exception.error,
              stackTrace: exception.stackTrace,
              response: exception.response!);
        case 403:
          return Forbidden(
              error: exception.error,
              stackTrace: exception.stackTrace,
              response: exception.response!);
        case 404:
          return ResourceNotFound(
              error: exception.error,
              stackTrace: exception.stackTrace,
              response: exception.response!);
        case 409:
          return ConflictError(
              error: exception.error,
              stackTrace: exception.stackTrace,
              response: exception.response!);
        case 500:
          return InternalServerError(
              error: exception.error,
              stackTrace: exception.stackTrace,
              response: exception.response!);
        default:
          return EmptyResponseError();
      }
    } else {
      return EmptyResponseError();
    }
  }
}

class ParsingResponseError extends NetworkError {
  ParsingResponseError({required super.error, required super.stackTrace})
      : super();
}

class BadRequest extends NetworkError {
  BadRequest(
      {required super.error,
      required super.stackTrace,
      required super.response})
      : super();
} // 400

class UnauthorizedError extends NetworkError {
  UnauthorizedError(
      {required super.error,
      required super.stackTrace,
      required super.response})
      : super();
} // 401

class Forbidden extends NetworkError {
  Forbidden(
      {required super.error,
      required super.stackTrace,
      required super.response})
      : super();
} // 403

class ResourceNotFound extends NetworkError {
  ResourceNotFound(
      {required super.error,
      required super.stackTrace,
      required super.response})
      : super();
} // 404

class ConflictError extends NetworkError {
  ConflictError(
      {required super.error,
      required super.stackTrace,
      required super.response})
      : super();
} // 409

class InternalServerError extends NetworkError {
  InternalServerError(
      {required super.error,
      required super.stackTrace,
      required super.response})
      : super();
} // 500

class EmptyResponseError extends NetworkError {
  EmptyResponseError({super.error, super.stackTrace, super.response}) : super();
}

class NetworkConnectionError extends NetworkError {
  NetworkConnectionError({super.error, super.stackTrace}) : super();
}
