import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'config.dart';
import 'custom_log_interceptor.dart';

typedef OnError = void Function(String error, Map<String, dynamic> data);
typedef OnResponse<Response> = void Function(Response response);

class DioFactory {
  static APILog apiLog = APILog.cURL;

  static final _singleton = DioFactory._instance();

  static Dio? get dio => _singleton._dio;
  static var _authorization = '';

  static void initialiseHeaders(String token) {
    _authorization = 'Bearer $token';
    dio!.options.headers[HttpHeaders.authorizationHeader] = _authorization;
  }

  static String baseURL = "";

  Dio? _dio;

  ///TODO : Base URL
  DioFactory._instance() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseURL,
        headers: {
          HttpHeaders.authorizationHeader: _authorization,
        },
        connectTimeout: Config.timeout,
        receiveTimeout: Config.timeout,
        sendTimeout: Config.timeout,
      ),
    );
    if (!kReleaseMode) {
      _dio!.interceptors.add(
        CustomLogInterceptor(
          request: Config.logNetworkRequest,
          requestHeader: Config.logNetworkRequestHeader,
          requestBody: Config.logNetworkRequestBody,
          responseHeader: Config.logNetworkResponseHeader,
          responseBody: Config.logNetworkResponseBody,
          error: Config.logNetworkError,
          cURLRequest: APILog.cURL == apiLog,
        ),
      );
    }
  }
}
