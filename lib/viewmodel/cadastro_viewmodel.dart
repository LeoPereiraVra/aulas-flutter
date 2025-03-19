import 'dart:convert';
import 'dart:io';

import 'package:app_provider/database/AppDataBase.dart';
import 'package:app_provider/model/contatos.dart';
import 'package:app_provider/service/contato_service.dart';
import 'package:app_provider/util/result.dart';
import 'package:app_provider/util/status.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class CadastroViewmodel with ChangeNotifier, DiagnosticableTreeMixin {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  XFile? get image => _image;

  Status _status = Status.nome();

  Status get status => _status;

  final Contato _contato = Contato("","","");

  Future<void> takePhoto() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    _image = image;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    _image = image; // Armazena a imagem
    notifyListeners();
  }

  Future<void> salvar(String? nome, String? telefone ) async {
    _contato.nome = nome??"";
    _contato.telefone = telefone??"";
    if (_image != null){

      File file = File(_image!.path);
      List<int> imageBytes = await file.readAsBytes();
      String base64String = base64Encode(imageBytes);
      _contato.image = base64String;
    }

    var service = ContatoApiClient();
    await service.salvar(_contato).then((result){
        switch(result){
          case Ok<Contato>() :
            Appdatabase.insertContato(result.value);
            _status = Status.success(""); 
            notifyListeners();
          
          case Error():            
            _status = Status.error(result.error); 
            notifyListeners();
        }         
    });

  }
}
