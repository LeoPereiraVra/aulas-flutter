import 'package:app_provider/database/AppDataBase.dart';
import 'package:app_provider/util/constants.dart';
import 'package:app_provider/view/home.dart';
import 'package:app_provider/view/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();    
  }

  Future<void> checkLoginStatus(BuildContext ctx) async {

    //var db = await openDatabase('my_db.db');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? isLoggedIn = prefs.getString(Constants.KEY_ACCESS_TOKEN);

    Appdatabase.create().then((value) async {      
      await Future.delayed(Duration(seconds: 5)); // Simula tempo de carregamento
        if (isLoggedIn != null) {
        Navigator.pushReplacement(
          ctx,
          MaterialPageRoute(builder: (ctx) => HomeScreen()),
        );
      } else {
        Navigator.pushReplacement(
          ctx,
          MaterialPageRoute(builder: (ctx) => LoginScreen()),
        );
      }
    });

    
  }

  @override
  Widget build(BuildContext context) {
    checkLoginStatus(context);
    return Scaffold(
      body: Center(child: Image.asset('images/logo.png')), // Indicador de carregamento
    );
  }
}
