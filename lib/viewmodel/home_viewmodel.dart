import 'dart:io';

import 'package:app_provider/model/contatos.dart';
import 'package:app_provider/service/contato_service.dart';
import 'package:app_provider/util/constants.dart';
import 'package:app_provider/util/result.dart';
import 'package:app_provider/util/status.dart';
import 'package:flutter/foundation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewmodel with ChangeNotifier, DiagnosticableTreeMixin {
  
  Status _status = Status.nome();
  Status get status => _status;

  HomeViewmodel(){
    buscarProdutos();
  }

  void buscarProdutos() async {

    if (_status is Carregando) return;    

    _status = Status.carregando("Loading...");
    notifyListeners();
    var api =  ContatoApiClient();
    api.buscarContatos().then((value) {

      switch(value){
        case Ok<List<Contato>>() :        
        _status = Status.success(value.value);
        case Error<List<Contato>>():
        _status = Status.error(value.error);

      }
      notifyListeners();
    });
  }

  Future<void> share(Contato contato) async {
    if (contato != null) {
      String textoCompartilhamento = """
          📞 *Contato:*
          👤 Nome: ${contato.nome}
          📱 Telefone: ${contato.telefone}
          🖼 Foto: ${contato.foto}
          """;
      await Share.share(textoCompartilhamento);
    }
  }

  Future<void> logout() async {

    return SharedPreferences.getInstance().then((prefs){
      prefs.remove(Constants.KEY_ACCESS_TOKEN);  
    });
  }
  
}