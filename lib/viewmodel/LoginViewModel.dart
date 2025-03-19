import 'package:app/model/AuthResponse.dart';
import 'package:app/service/loginService.dart';
import 'package:app/util/result.dart';
import 'package:app/util/status.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel with ChangeNotifier, DiagnosticableTreeMixin {
  String login = "";
  String senha = "";
  Status status = Status.nome();

  var loginService = Loginservice();

  void logar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    status = Status.carregando("");
    notifyListeners();
    loginService.login(login, senha).then((retorno) {
      switch (retorno) {
        case Ok<AuthResponse>():
          prefs.setString("TOKEN", retorno.value.token);
          status = Status.success("Login realizado com sucesso");
        case Error<AuthResponse>():
          status = Status.error(retorno.error.toString());
      }
      notifyListeners();
    });
  }

  void setLogin(String prLogin) {
    login = prLogin;
  }

  void setSenha(String prSenha) {
    senha = prSenha;
  }
}
