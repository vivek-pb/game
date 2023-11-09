import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class CustomLogInterceptor extends Interceptor {
  final bool? request,
      requestHeader,
      requestBody,
      responseHeader,
      responseBody,
      error,
      cURLRequest;

  CustomLogInterceptor({
    this.request,
    this.requestHeader,
    this.requestBody,
    this.responseHeader,
    this.responseBody,
    this.error,
    this.cURLRequest,
  });

  String cURLRepresentation(RequestOptions options) {
    List<String> components = ["curl -i"];
    if (options.method.toUpperCase() == "GET") {
      components.add("-X ${options.method}");
    }

    options.headers.forEach((k, v) {
      if (k != "Cookie") {
        components.add("-H \"$k: $v\"");
      }
    });

    var data = json.encode(options.data);
    data = data.replaceAll('\'', '');
    components.add("-d \"$data\"");

    components.add("\"${options.uri.toString()}\"");

    return components.join('\\\n\t');
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('*** Response ***', name: 'dio');
    _printResponse(response);
    handler.next(response);
  }

  void _printResponse(Response response) {
    _printKV('uri', response.requestOptions.uri);
    if (responseHeader!) {
      _printKV('statusCode', response.statusCode);
      if (response.isRedirect == true) {
        _printKV('redirect', response.realUri);
      }

      log('headers:', name: 'dio');
      response.headers.forEach((key, v) => _printKV(' $key', v.join('\r\n\t')));
    }
    if (responseBody!) {
      log('Response Text:', name: 'dio');
      log(response.toString());
    }
    log('');
  }

  void _printKV(String key, Object? v) {
    log('$key: $v', name: 'dio');
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (error!) {
      log('*** DioError ***:', name: 'dio');
      log('uri: ${err.requestOptions.uri}', name: 'dio');
      log('$err', name: 'dio');
      if (err.response != null) {
        log('${err.response!}');
      }
      log('');
    }

    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('*** Request ***', name: 'dio');

    if (request!) {
      log('method: ${options.method}', name: 'dio');
      log('responseType: ${options.responseType.toString()}', name: 'dio');
      // log('followRedirects: ${options.followRedirects}', name: 'dio');
      // log('connectTimeout: ${options.connectTimeout}', name: 'dio');
      // log('sendTimeout: ${options.sendTimeout}', name: 'dio');
      // log('receiveTimeout: ${options.receiveTimeout}', name: 'dio');
      // log('receiveDataWhenStatusError: ${options.receiveDataWhenStatusError}',
      //     name: 'dio');
      log('extra: ${options.extra}', name: 'dio');
    }

    if (requestHeader!) {
      log('headers:', name: 'dio');
      options.headers.forEach((key, v) => log(' $key : $v', name: 'dio'));
    }

    if (requestBody!) {
      log('data:');
      log(options.data.toString());
    }
    log('================================ \n \n');

    if (cURLRequest!) {
      log("""REQUEST:
    ${cURLRepresentation(options)}
    """);
      log('================================ \n \n');
    }
    handler.next(options);
  }
}
