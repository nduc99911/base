import 'dart:io';
import 'package:base_pm2/commons/resource/export_resource.dart';
import 'package:base_pm2/commons/resource/map_resource.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'rest_client.dart';

class NetworkUtils {
  static RestClient? client;

  static Future<RestClient> getClientInstance() async {
    if (client == null) {
      Dio dio = await _getDioClient();
      client = RestClient(dio);
    }
    return client!;
  }

  static Future<Dio> _getDioClient() async {
    String token = KeyResource.tokenKey;
    Dio? dio;
    if (dio == null) {
      dio = Dio(BaseOptions(
          baseUrl: baseUrl[KeyResource.dev],
          contentType: "application/json",
          headers: <String, dynamic>{
            "Authorization": "Bearer $token",
          }));
      dio.interceptors.add(
        PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: true,
            error: true,
            compact: true),
      );
    }
    return dio;
  }

  static Future<bool> hasConnection() async {
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}
