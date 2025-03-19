class Contato {
  String nome;
  String telefone;
  String foto;
  String? image;

  Contato(this.nome, this.telefone, this.foto, { this.image });

  Contato.fromJson(Map<String, dynamic> json)
    : nome = json['nome'] as String,
      telefone = json['telefone'] as String,
      foto = json['foto'] as String,
      image = null;

  Map<String, dynamic> toJson() => {'nome': nome, 'telefone' : telefone, 'imagem': image };


  Map<String, Object> toMap() => {           
        'nome': nome,
        'telefone': telefone,
        'foto' : foto
      };  
}
