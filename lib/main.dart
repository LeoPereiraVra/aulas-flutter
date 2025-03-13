import 'package:app/Aplicativo.dart';
import 'package:app/viewmodel/LoginViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => LoginViewModel(),
      child: Aplicativo(),
    ),
  );
}
