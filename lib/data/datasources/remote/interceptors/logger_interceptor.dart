import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggerInterceptor extends Interceptor {
  final Logger _logger = Logger(
      printer:
          PrettyPrinter(dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart));

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.i({
      "method": options.method,
      "path": options.uri.toString(),
      "query parameters": options.queryParameters,
      "headers": options.headers,
      "request": options.data is FormData
          ? {
              'form_data': (options.data as FormData).fields,
              'form_files': (options.data as FormData).files
            }
          : options.data,
    });
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e(
      {
        "method": err.requestOptions.method,
        "path": err.requestOptions.uri.toString(),
        "query parameters": err.requestOptions.queryParameters,
        "headers": err.requestOptions.headers,
        "status code": err.response?.statusCode,
        "response": err.response?.data
      },
      error: err,
    );
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.d({
      "method": response.requestOptions.method,
      "path": response.requestOptions.uri.toString(),
      "query parameters": response.requestOptions.queryParameters,
      "headers": response.requestOptions.headers,
      "status code": response.statusCode,
      "response": response.data
    });
    super.onResponse(response, handler);
  }
}
