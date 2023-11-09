import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import '../test_model.dart';
import 'dio_factory.dart';

enum HttpMethod { delete, get, patch, post, put }

extension HttpMethods on HttpMethod {
  String? get value {
    switch (this) {
      case HttpMethod.delete:
        return 'DELETE';
      case HttpMethod.get:
        return 'GET';
      case HttpMethod.patch:
        return 'PATCH';
      case HttpMethod.post:
        return 'POST';
      case HttpMethod.put:
        return 'PUT';
      default:
        return null;
    }
  }
}

class Api {
  static const tag = "Api";

  //General Request
  static Future<void> request<T>({
    HttpMethod method = HttpMethod.get,
    required String path,
    required APIResponse res,
    required String key,
    Map<String, dynamic>? params,
    OnResponse? onResponse,
  }) async {
    try {
      dio.Response response;
      switch (method) {
        case HttpMethod.post:
          response = await DioFactory.dio!.post(
            path,
            options: Options(
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
              },
            ),
            data: params,
          );
          break;
        case HttpMethod.delete:
          response = await DioFactory.dio!.delete(
            path,
            data: params,
          );
          break;
        case HttpMethod.get:
          response = await DioFactory.dio!.get(path, queryParameters: params);
          break;
        case HttpMethod.patch:
          response = await DioFactory.dio!.patch(
            path,
            data: params,
          );
          break;
        case HttpMethod.put:
          response = await DioFactory.dio!.put(
            path,
            options: Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            }),
            data: params,
          );
          break;
        default:
          return;
      }

      if (response.statusCode == 401) {
        print("");
      } else {
        res.onResponse(key, response.data);
      }
    } catch (e) {
      String errorMessage = "";
      if (e is DioException) {
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.sendTimeout ||
            e.type == DioExceptionType.receiveTimeout ||
            e.type == DioExceptionType.unknown) {
          errorMessage = 'Server unreachable';
        } else if (e.type == DioExceptionType.badResponse) {
          errorMessage = e.response!.data['detail'];
        } else {
          errorMessage = "Request cancelled";
        }
      } else {
        errorMessage = "Something went wrong! Please try again.";
      }
      print('errorMessage : $e');
    }
  }
}

///API response manager
mixin class APIResponse {
  onResponse(String apiKey, dynamic response) {}

  onError(String apiKey, String error) {}
}

///Provider
class HomeProvider extends APIResponse {
  init() {
    APIRepo(this);
    VivekAPI.callAPI.api();
  }

  List<TestModel> list = [];

  @override
  onResponse(String apiKey, response) {
    print("List : ${list.length}");
  }

  @override
  onError(String apiKey, String error) {}
}

///API repo : Call all API
class APIRepo {
  static final APIRepo _singleton = APIRepo._internal();

  factory APIRepo(APIResponse response) {
    _res = response;
    return _singleton;
  }

  static late APIResponse _res;

  static APIResponse get res => _res;

  APIRepo._internal();

  static callAPI() {
    Api.request(
      path:
          "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1&sparkline=true&price_change_percentage=7d",
      res: res,
      key: "call",
    );
  }
}

enum VivekAPI { callAPI }

extension ExtensionOnVivekAPI on VivekAPI {
  api() {
    switch (this) {
      case VivekAPI.callAPI:
        APIRepo.callAPI();
        break;
      default:
        print("call Any API");
        break;
    }
  }
}

enum Models {
  testModel,
}

extension ExtensionOnModels on Models {
  parse(dynamic response) {
    switch (this) {
      case Models.testModel:
        return List<TestModel>.from(response.map((e) => TestModel.fromJson(e)));
      default:
        return "";
    }
  }
}
