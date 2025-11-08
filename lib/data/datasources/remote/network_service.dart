import 'dart:async';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../../../utils/config/app_config.dart';
import 'interceptors/logger_interceptor.dart';
import 'models/endpoint.dart';
import 'models/network_error.dart';
import 'models/result.dart';

typedef ResponseParser<T> = T Function(dynamic responseJson);

final StreamController<NetworkError> networkErrorsStreamController =
    StreamController<NetworkError>.broadcast();

class NetworkService {
  final Logger _logger = Logger();

  static Dio? _dioObj;

  Dio get _dioClient {
    if (_dioObj == null) {
      _dioObj = Dio(
        BaseOptions(
          baseUrl: '${AppConfig.baseUrl}${AppConfig.apiVersion}',
          headers: {
            'Accept': 'application/json;charset=utf-8',
            'Accept-Language': 'en',
          },
        ),
      );
      _dioClient.interceptors.addAll([LoggerInterceptor()]);
    }
    return _dioObj!;
  }

  Future<Result<T?>> sendRequest<T>({
    required Endpoint endpoint,
    ResponseParser<T>? responseParser,
  }) async {
    assert(
      T == dynamic || responseParser != null,
      'You have to add a response parser for this request',
    );
    Response? response;
    try {
      response = await _dioClient.request(
        endpoint.path,
        data: endpoint.body ?? endpoint.formData,
        queryParameters: endpoint.queryParameters,
        options: Options(
          method: endpoint.httpMethod.name,
          headers: endpoint.headers,
        ),
      );
    } on DioException catch (dioException, dioStacktrace) {
      try {
        var data = (dioException.response?.data.isNotEmpty ?? false)
            ? await _parseResponse(responseParser, dioException.response?.data)
            : null;
        var error = NetworkError.fromDioException(dioException);
        networkErrorsStreamController.add(error);
        _logger.e(
          "dio error ${dioException.runtimeType}, network error type ${error.runtimeType}",
          error: dioException,
          stackTrace: dioStacktrace,
        );
        return Result<T>.error(error: error, data: data);
      } catch (e, s) {
        if (e is ParsingResponseError) {
          _logger.e(
            "error in parsing response ${e.runtimeType}",
            error: e.error,
            stackTrace: s,
          );
        }
        var error = NetworkError.fromDioException(dioException);
        networkErrorsStreamController.add(error);
        _logger.e(
          "error returned from network service ${error.runtimeType} with dio error ${dioException.runtimeType}",
          error: error.error,
          stackTrace: error.stackTrace,
        );
        return Result<T>.error(error: error, data: null);
      }
    } catch (e, s) {
      _logger.e(
        "error in network service ${e.runtimeType}",
        error: e,
        stackTrace: s,
      );
      var error = NetworkConnectionError(error: e, stackTrace: s);
      networkErrorsStreamController.add(error);
      return Result<T>.error(error: error);
    }
    //success
    try {
      return Result<T>.success(
        await _parseResponse(responseParser, response.data),
      );
    } on NetworkError catch (error) {
      _logger.e(
        "error in network service request success but failed to parse response  ${error.runtimeType}",
        error: error.error,
        stackTrace: error.stackTrace,
      );
      networkErrorsStreamController.add(error);
      return Result<T>.error(error: error);
    }
  }

  Future<T?> _parseResponse<T>(
    ResponseParser<T>? responseParser,
    dynamic responseJson,
  ) async {
    if (responseParser == null ||
        responseJson == null ||
        (responseJson is Iterable && responseJson.isEmpty)) {
      return null;
    }
    return Isolate.run(() => responseParser(responseJson)).catchError((e, s) {
      throw ParsingResponseError(error: e, stackTrace: s);
    });
  }
}
