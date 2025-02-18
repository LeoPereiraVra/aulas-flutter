import 'package:app/main.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image(image: NetworkImage("https://avatars.githubusercontent.com/u/14101776?s=280&v=4"),),
          Image.asset("assets/imagens/flutter.png", width: 100, height: 100,),
          Text("Login"),
          TextFormField(),
          Text("Senha"),
          TextFormField(),
          TextButton(onPressed: (){
            Navigator.pop(context, MaterialPageRoute(builder: (context) => MyHomePage(title: "title")));
          }, child: Text("Logar"))
        ],        
      ),
    );
  }
}