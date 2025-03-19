import 'dart:math';

import 'package:app_provider/util/status.dart';
import 'package:app_provider/view/home.dart';
import 'package:app_provider/viewmodel/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        ///Mostrar sem isso pra exibir o erro nos imputs
        child: Center(
          child: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 50),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 1.0,
                        spreadRadius: 0.0,
                        offset: Offset(1.0, 1.0),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(70),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(120),
                    child: Image.asset(
                      'images/logo.png',
                      fit: BoxFit.cover,
                      width: 120,
                      height: 120,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: TextField(
                    cursorColor: Colors.black,
                    onChanged:
                        (value) =>
                            context.read<LoginViewmodel>().setLogin(value),
                    decoration: InputDecoration(prefixIcon: Icon(Icons.person)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 50),
                  child: TextField(
                    obscureText: true,
                    onChanged:
                        (value) =>
                            context.read<LoginViewmodel>().setPassword(value),
                    decoration: InputDecoration(prefixIcon: Icon(Icons.lock)),
                  ),
                ),
                Consumer<LoginViewmodel>(
                  builder: (context, login, child) {
                    if (login.status is Carregando) {
                      return CircularProgressIndicator(color: Colors.blue);
                    } else if (login.status is Erro) {
                      return Text(
                        login.status.toString(),
                        style: TextStyle(color: Colors.red),
                      );
                    } else if (login.status is Success) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      });
                    }
                    return SizedBox();
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<LoginViewmodel>().logar();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text("LOGIN", style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
