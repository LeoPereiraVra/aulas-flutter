import 'package:app_provider/view/home.dart';
import 'package:app_provider/view/login.dart';
import 'package:app_provider/view/splash.dart';
import 'package:flutter/material.dart';

class Aplicativo extends StatelessWidget {
  const Aplicativo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white, // Cor base do tema
          primary: Colors.white, // Cor principal
          secondary: Colors.orange,
        ),

        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 5.0),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          enabledBorder: OutlineInputBorder(
            // Borda quando o campo não está focado
            borderSide: BorderSide(
              color: Colors.grey, // Cor da borda desabilitada
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            // Borda quando o campo está
            //6 focado
            borderSide: BorderSide(
              color: Colors.grey, // Cor da borda quando recebe foco
              width: 2.0,
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: TextStyle(color: Colors.white),
            backgroundColor: Color.fromRGBO(101, 85, 143, 1), // Cor do botão
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.black),
      ),
      home: SplashScreen(),
    );
  }
}
