class User {

  final String nome;
  final String login;
  
  User(this.nome, this.login);

  User.fromJson(Map<String, dynamic> json)
    : nome = json['name'] as String,
      login = json['login'] as String;

  Map<String, dynamic> toJson() => {'nome': nome, 'login': login};
  
}