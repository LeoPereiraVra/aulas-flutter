import 'dart:ffi';

import 'package:app_provider/database/AppDataBase.dart';
import 'package:app_provider/model/contatos.dart';
import 'package:app_provider/service/api_service.dart';
import 'package:app_provider/util/result.dart';

class ContatoApiClient extends ApiService {

  Future<Result<List<Contato>>> buscarContatos() async {
    try {
      var result = await get("api/v1/contatos");

      switch (result) {
        case Ok<List<dynamic>>():
          //var contatos = Appdatabase.getContatos(); Buscar do banco de dados local
          List<Contato> contatos = result.value.map((obj) => Contato.fromJson(obj)).toList();
          return Result.ok(contatos);
        case Error<List<dynamic>>():
          return Result.error(result.error);
      }
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  Future<Result<Contato>> salvar(Contato contato) async {
    try {
      var result = await post("api/v1/contatos",params: contato.toJson());

      switch (result) {
        case Ok<Map<String, dynamic>>():   
          var contato = Contato.fromJson(result.value);
          return Result.ok(contato);
        case Error<Map<String, dynamic>>():
          return Result.error(result.error);
      }
    } on Exception catch (error) {
      return Result.error(error);
    }
  }


}
