import 'package:app/model/Contato.dart';
import 'package:app/service/homeService.dart';
import 'package:app/util/result.dart';
import 'package:app/util/status.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel with ChangeNotifier, DiagnosticableTreeMixin {


  Status<List<Contato>> _status = Status.nome();
  Status get status => _status;


  HomeViewModel(){
    buscaContatos();
  }

  void buscaContatos() async {
    _status = Status.carregando("Buscando...");
    notifyListeners();

    final homeService = HomeService();
    homeService.buscarContatos().then((contatos){
      switch(contatos){
        case Ok<List<Contato>>() :        
        _status = Status.success(contatos.value);
        case Error<List<Contato>>():
        _status = Status.error(contatos.error.toString());

      }
      notifyListeners();
    });


  }

  Future<void> logout() async{
    return SharedPreferences.getInstance().then((prefs){
      prefs.remove('TOKEN');
    });
  }
}
