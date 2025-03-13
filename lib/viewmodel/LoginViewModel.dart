import 'package:app/service/loginService.dart';
import 'package:app/util/status.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginViewModel with ChangeNotifier, DiagnosticableTreeMixin {


  String login = "";
  String senha = "";
  Status status = Status.nome();

  var loginService = Loginservice();

   void logar() {
      status = Status.carregando("");
      notifyListeners();
      loginService.login(login, senha).then((_){
        status = Status.error("Erro ao realizar login");
        notifyListeners();
      });
  }

  void setLogin(String prLogin){
    login = prLogin;
  }

  void setSenha(String prSenha){
    senha = prSenha;
  }

}