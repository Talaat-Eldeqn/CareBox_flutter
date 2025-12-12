import 'package:carebox/core/network/api_respose.dart';
import 'package:carebox/core/network/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiHelper {
  // singleton
  static final ApiHelper _instance = ApiHelper._init();
  factory ApiHelper() {
    _instance.initDio();
    return _instance;
  }
  ApiHelper._init();

  late Dio dio;

  void initDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseURL,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.clear();

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint("--- API Request ---> ${options.method} ${options.path}");
          debugPrint("Data: ${options.data}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint(
            "--- API Response <--- ${response.statusCode} ${response.requestOptions.path}",
          );
          debugPrint("Response data: ${response.data}");
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          debugPrint(
            "--- API Error <<< ${error.response?.statusCode} ${error.requestOptions.path}",
          );
          debugPrint("Error data: ${error.response?.data}");
          return handler.next(error);
        },
      ),
    );
  }

  Future<ApiResponse> postRequest({
    required String endPoint,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await dio.post(endPoint, data: data ?? {});
      return ApiResponse.fromResponse(response);
    } on DioException catch (e) {
      return ApiResponse.fromError(e);
    } catch (e) {
      return ApiResponse.fromError(e);
    }
  }

  Future<ApiResponse> getRequest({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(
        endPoint,
        queryParameters: queryParameters,
      );
      return ApiResponse.fromResponse(response);
    } on DioException catch (e) {
      return ApiResponse.fromError(e);
    } catch (e) {
      return ApiResponse.fromError(e);
    }
  }

  Future<ApiResponse> putRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.put(
        endPoint,
        data: data ?? {},
        queryParameters: queryParameters,
      );
      return ApiResponse.fromResponse(response);
    } on DioException catch (e) {
      return ApiResponse.fromError(e);
    } catch (e) {
      return ApiResponse.fromError(e);
    }
  }

  Future<ApiResponse> deleteRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.delete(
        endPoint,
        data: data ?? {},
        queryParameters: queryParameters,
      );
      return ApiResponse.fromResponse(response);
    } on DioException catch (e) {
      return ApiResponse.fromError(e);
    } catch (e) {
      return ApiResponse.fromError(e);
    }
  }
}
