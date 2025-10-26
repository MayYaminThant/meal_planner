// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../components/export_files.dart';
import 'api_path.dart';

class ApiServiceConfig {
  static const int apiVersion = 1;
  static const int loadPagePerCount = 40;
  static const Duration sendTimeout = Duration(milliseconds: 60000);
  static const Duration receiveTimeout = Duration(milliseconds: 60000);

  static const int connectionTimeout = 15000;
  static get apiServiceBaseOptions => BaseOptions(
          baseUrl: Api.baseUrl,
          connectTimeout: sendTimeout,
          receiveTimeout: receiveTimeout,
          headers: {
            "Cache-Control": "no-cache",
            "Accept": "*/*",
          });

  static DioExceptionType dioErrorHandler(
    DioException dioException, {
    String? errorSpecificmessage,
    Duration? errorSpecificmessageDuration,
  }) {
    if (dioException.type == DioExceptionType.connectionTimeout) {
      CommonUtils.showAlertDialogWithOkButton(content: "Request Timeout");
      return DioExceptionType.connectionTimeout;
    }

    if (dioException.type == DioExceptionType.receiveTimeout) {
      CommonUtils.showAlertDialogWithOkButton(content: "Receive Timeout");
      return DioExceptionType.receiveTimeout;
    }

    if (dioException.type == DioExceptionType.sendTimeout) {
      CommonUtils.showAlertDialogWithOkButton(content: "Send Timeout");
      return DioExceptionType.sendTimeout;
    }

    if (dioException.response != null) {
      if (errorSpecificmessage != null) {
        CommonUtils.showAlertDialogWithOkButton(content: errorSpecificmessage);
      } else {
        log(
          dioException.response?.statusCode.toString() ?? "Unknown Status Code",
        );

        if (dioException.response?.statusCode == 401) {
          return DioExceptionType.badCertificate;
        }

        CommonUtils.showAlertDialogWithOkButton(
          content: dioException.response?.data != null &&
                  dioException.response!.data is String &&
                  dioException.response!.data.toString().trim().isNotEmpty
              ? dioException.response!.data.toString()
              : (dioException.response?.statusMessage ?? 'Something was wrong'),
        );
      }
    } else {
      CommonUtils.showAlertDialogWithOkButton(
        content:
            'Something was wrong. Please check your internet connection and try again.',
      );
    }

    return DioExceptionType.unknown;
  }
}

extension OnApiEndPoint on String {
  String onApiEndPoint() {
    return "${Api.baseUrl}/api$this";
  }
}

extension OnEndPoint on String {
  String onEndPoint() => Api.currentAppUrl + this;
}

Dio dio = Dio(ApiServiceConfig.apiServiceBaseOptions);

enum Method {
  GET,
  POST,
  PUT,
  DELETE,
}

class Api {
  static const String baseUrl = "https://api.spoonacular.com";

//--------------------------------------------------------------------------------------

  static const String currentAppUrl = baseUrl;
  static const int receiveTimeout = 60000;
  static const int connectionTimeout = 60000;

  static openConsoleLoging() {}

  static void resetDio() {
    dio.close(force: true);
    dio = Dio(ApiServiceConfig.apiServiceBaseOptions);
  }

  static debugingResponse({Response<dynamic>? response}) {
    if (response != null) {
      log("RESPONSE CODE : ${response.statusCode}");
      log("RESPONSE CODE MESSAGE : ${response.statusMessage}");
      log("RESPONSE DATA : ${response.data}");
    } else {
      log("UNKNOWN RESPONSE");
    }
  }

  //!---------------------------Request--------------------------------
  static Future<Response<dynamic>?> request({
    required String endpoint,
    String? method,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    Function()? callback,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      var response = await dio.request(
        endpoint,
        options: options ??
            Options(
              method: method,
              contentType: "application/json",
              receiveTimeout: receiveTimeout,
              sendTimeout: sendTimeout,
            ),
        data: data,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
      );
      callback?.call();
      return response;
    } on DioException catch (dioException) {
      // ApiServiceConfig.dioErrorHandler(dioException);
      final error = ApiServiceConfig.dioErrorHandler(dioException);

      if (error == DioExceptionType.badCertificate) {
      } else {}

      callback?.call();
      return dioException.response;
    } catch (e) {
      callback?.call();
      // CommonUtils.saveAPIErrorLogs(e.toString());
      return null;
    }
  }

  static Future<Response?> getRandomRecipes({
    int Function(int, int)? progressfunciton,
  }) async {
    dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    String apiKey = dotenv.get('API_KEY', fallback: '');
    return request(
      endpoint: APIPath.getRandomRecipes.onEndPoint(),
      method: Method.GET.name,
      onSendProgress: progressfunciton,
      queryParameters: {
        "limitLicense": true,
        "number": 30,
        "apiKey": apiKey,
      },
    );
  }

  static Future<Response?> getRecipesByIngredients({
    required String searchIngredients,
    int Function(int, int)? progressfunciton,
  }) async {
    dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    // Data is not included completely (e.g Ingredients, Instructions)
    String apiKey = dotenv.get('API_KEY', fallback: '');
    return request(
      endpoint: APIPath.getRecipesByIngredients.onEndPoint(),
      method: Method.GET.name,
      onSendProgress: progressfunciton,
      queryParameters: {
        "limitLicense": true,
        "number": 30,
        "apiKey": apiKey,
        "ingredients": searchIngredients,
        "ranking": 1,
        "ignorePantry": false,
      },
    );
  }

  static Future<Response?> getSimilarRecipes({
    required int similarId,
    int Function(int, int)? progressfunciton,
  }) async {
    dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    String apiKey = dotenv.get('API_KEY', fallback: '');
    return request(
      endpoint: APIPath.getSimilarRecipes
          .replaceFirst(":id", '$similarId')
          .onEndPoint(),
      method: Method.GET.name,
      onSendProgress: progressfunciton,
      queryParameters: {
        "limitLicense": true,
        "number": 10,
        "apiKey": apiKey,
      },
    );
  }
}
