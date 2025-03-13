import 'dart:io';

import 'package:app/util/result.dart';
import 'package:dio/dio.dart';

class Loginservice {
  final Dio _cliente = Dio();

  Future<Result<Map<String, String>>> login(String usuario, String senha) async {
    
    return Map();
  }
}
