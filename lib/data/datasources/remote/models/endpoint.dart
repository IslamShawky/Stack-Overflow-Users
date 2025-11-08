// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';


enum HttpMethod {
  PATCH,
  POST,
  GET,
  DELETE;
}

class Endpoint {
  final String path;
  final HttpMethod httpMethod;
  final Map<String, dynamic>? queryParameters;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? body;
  final FormData? formData;

  Endpoint({
    required this.path,
    required this.httpMethod,
    this.queryParameters,
    this.headers,
    this.body,
    this.formData,
  });
}
