import 'package:app/view/LoginView.dart';
import 'package:flutter/material.dart';

class Aplicativo extends StatelessWidget {
  const Aplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white,
        primary: Colors.white),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 5.0),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1.5
            )
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey, // Cor da borda quando recebe foco
              width: 2.0,
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: TextStyle(color: Colors.white),
            backgroundColor: Color.fromRGBO(101, 85, 143, 1)
          )
        ),
        textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.black)
      ),
      home: LoginView(),
    );
  }
}
