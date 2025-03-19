import 'package:app/model/Contato.dart';
import 'package:app/service/api_service.dart';
import 'package:app/util/result.dart';

class HomeService extends ApiService {
  Future<Result<List<Contato>>> buscarContatos() async {
    final retorno = await get("api/v1/contatos");

    switch (retorno) {
      case Ok<List<dynamic>>():
        List<Contato> contato = retorno.value.map((json) => Contato.fromJson(json)).toList();
        return Result.ok(contato);
      case Error<List>():        
        throw UnimplementedError();
    }
  }
}
