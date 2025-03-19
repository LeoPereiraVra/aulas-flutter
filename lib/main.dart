import 'package:app_provider/aplicativo.dart';
import 'package:app_provider/viewmodel/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {

  runApp(
    ChangeNotifierProvider(
      create: (context) => LoginViewmodel(),
      child: Aplicativo(),
    ),
  );
}
