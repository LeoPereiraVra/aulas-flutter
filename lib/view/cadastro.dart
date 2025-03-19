import 'dart:io';

import 'package:app_provider/util/status.dart';
import 'package:app_provider/viewmodel/cadastro_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroWidgetState();
}

class _CadastroWidgetState extends State<CadastroScreen> {
  TextEditingController nomeControler = TextEditingController();
  TextEditingController telController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CADASTRO")),
      body: ChangeNotifierProvider(
        create: (_) => CadastroViewmodel(),
        child: Consumer<CadastroViewmodel>(
          builder: (context, viewModel, child) {
            return SingleChildScrollView(
              ///Mostrar sem isso pra exibir o erro nos imputs              
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
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
                          child:
                              (viewModel.image == null)
                                  ? Icon(
                                    Icons.person,
                                    size: 100,
                                    color: Colors.lightBlue,
                                  )
                                  : Image.file(
                                    fit: BoxFit.fill,
                                    File(viewModel.image!.path),
                                    width: 150,
                                    height: 150,
                                  ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: viewModel.takePhoto,
                            icon: Icon(Icons.camera_alt),
                          ),
                          IconButton(
                            onPressed: viewModel.pickImage,
                            icon: Icon(Icons.image),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 30),
                        child: TextField(
                          controller: nomeControler,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 50),
                        child: TextField(
                          controller: telController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.call),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          viewModel
                              .salvar(nomeControler.text, telController.text)
                              .then((result) {
                                if (viewModel.status is Success) {
                                  Navigator.pop(context);
                                } else {
                                  showDialog<String>(
                                    context: context,
                                    builder:
                                        (BuildContext context) => AlertDialog(
                                          title: const Text(
                                            'Atenção',
                                          ),
                                          content: const Text(
                                            'Erro ao salvar contato, tente novamente',
                                          ),
                                          actions: <Widget>[                                            
                                            TextButton(
                                              onPressed:
                                                  () => Navigator.pop(
                                                    context,
                                                    'OK',
                                                  ),
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                  );
                                }
                              });
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text(
                          "SALVAR",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
