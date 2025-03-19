import 'dart:io';

import 'package:app/model/AuthResponse.dart';
import 'package:app/util/result.dart';
import 'package:dio/dio.dart';

class Loginservice {
  final Dio _dio = Dio();

  Future<Result<AuthResponse>> login(
    String usuario,
    String senha,
  ) async {
    try {
      _dio.options.headers.addAll({"Accept" : "application/json"});
      final request = await _dio.post(
        "http://192.168.1.9:8001/api/v1/login",
        data: {"login": usuario, "password": senha},
      );

      if (request.statusCode == 200) {
        final Map<String, dynamic> data = request.data;
        return Result.ok(AuthResponse.fromJson(data['data']));
      } if (request.statusCode == 422) {
        return Result.error(await request.data['message']);
      } else {        
        return Result.error(HttpException("Erro login"));      
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
