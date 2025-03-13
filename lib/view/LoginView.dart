import 'package:app/util/status.dart';
import 'package:app/viewmodel/LoginViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: Image.asset(
                    "assets/imagens/logo.png",
                    fit: BoxFit.cover,
                    width: 120,
                    height: 120,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: TextField(                  
                  decoration: InputDecoration(prefixIcon: Icon(Icons.person)),
                  onChanged: context.read<LoginViewModel>().setLogin,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: TextField(                  
                  obscureText: true,
                  decoration: InputDecoration(prefixIcon: Icon(Icons.lock)),
                  onChanged: (value){
                    context.read<LoginViewModel>().setSenha(value);
                  },
                ),
              ),
              Consumer<LoginViewModel>(
                builder: (_, viewModel, _) {
                  if (viewModel.status is Carregando) {
                    return CircularProgressIndicator(color: Colors.blue);
                  } else if (viewModel.status is Erro) {
                    return Text(viewModel.status.toString());
                  } else if (viewModel.status is Success) {
                    return Text(viewModel.status.toString());
                  }else{
                    return Container();
                  }
                },
              ),
              Divider(height: 20,color: Colors.transparent,),
              ElevatedButton(
                onPressed: () {
                  context.read<LoginViewModel>().logar();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text("LOGIN"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
