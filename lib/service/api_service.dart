import 'dart:io';
import 'package:app_provider/util/constants.dart';
import 'package:app_provider/util/result.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService{
  
  
  final Dio _client = Dio();
  SharedPreferences? prefs;

  Future<void> initialize() async {
    // Espera a SharedPreferences ser carregada
    prefs ??= await SharedPreferences.getInstance();
    final token = prefs?.getString(Constants.KEY_ACCESS_TOKEN);

    // Configura o header de autorização se o token estiver disponível
    if (token != null) {
      _client.options.headers = {'Authorization': 'Bearer $token'};
    }
  }

  Future<Result<Map<String, dynamic>>> post(String path, {Object? params}) async {
    
    try {

      await initialize();
      
      final request = await _client.post("http://192.168.1.9:8001/$path",data: params);
      
      if (request.statusCode == 200) {        
        final Map<String, dynamic> data = await request.data;
           
        return Result.ok(data['data']);
      } else {
        return const Result.error(HttpException("Login error"));
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      _client.close();
    }
  }


  Future<Result<List<dynamic>>> get(String path, {Map<String, Object>? params}) async {
    
    try {

      await initialize();
      
      final request = await _client.get("http://192.168.1.9:8001/$path",queryParameters: params);
      
      if (request.statusCode == 200) {        
        final Map<String, dynamic> data = await request.data;
           
        return Result.ok(data['data']['data']);
      } else {
        return const Result.error(HttpException("Login error"));
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      _client.close();
    }
  }
}