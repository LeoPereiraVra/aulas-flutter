import 'package:app/view/HomeView.dart';
import 'package:app/view/LoginView.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  Future<void> checkLogin(BuildContext context) async {
    SharedPreferences.getInstance().then((prefs) {
      final token = prefs.getString("TOKEN");

      if (token != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeView()),
        );
      }else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginView()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    checkLogin(context);
    return Scaffold(
      body: Center(child: Image.asset("assets/imagens/logo.png")),
    );
  }
}
