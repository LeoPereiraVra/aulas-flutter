import 'dart:io';

import 'package:app/util/result.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<void> iniciar() async {
    SharedPreferences.getInstance().then((prefs) {
      final token = prefs.getString('TOKEN');

      if (token != null) {
        _dio.options.headers = {"Authorization": "Bearer $token"};
      }
    });
  }

  Future<Result<List<dynamic>>> get(String path, {Map<String, dynamic>? params}) async {
    await iniciar();
    final url = "http://192.168.1.9:8001/$path";
    final request = await _dio.get(url,queryParameters: params);

    if(request.statusCode == 200){
      final Map<String, dynamic> data = await request.data;
           
      return Result.ok(data['data']['data']);
    }else {
      return const Result.error(HttpException("Login error"));
    }
  }
}
