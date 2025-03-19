import 'package:app_provider/model/auth_response.dart';
import 'package:app_provider/model/user.dart';
import 'package:app_provider/service/login_service.dart';
import 'package:app_provider/util/constants.dart';
import 'package:app_provider/util/result.dart';
import 'package:app_provider/util/status.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewmodel with ChangeNotifier, DiagnosticableTreeMixin {
  

  String _login = "";
  String _password = "";

  Status _status = Status.nome();
  Status get status => _status;

  User? user;

  void logar() async {

    if (_status is Carregando) return;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    _status = Status.carregando("Loading...");
    notifyListeners();
    var api =  LoginApiClient();
    api.login(_login,_password).then((value) {

      switch(value){
        case Ok<AuthResponse>() :

        _status = Status.success(value.value.user);
        prefs.setString(Constants.KEY_ACCESS_TOKEN, value.value.accessToken);
        user = value.value.user;        
        case Error<AuthResponse>():
        _status = Status.error(value.error);

      }
      notifyListeners();
    });
  }
  
  void setLogin(String prLogin){
    _login = prLogin;
  }

  void setPassword(String prPass){
    _password = prPass;
  }

}