import 'package:app_provider/model/user.dart';

class AuthResponse {
  String accessToken;
  User user;

  // Construtor nomeado
  AuthResponse({required this.accessToken, required this.user});

  // Método de fábrica para criar uma instância de AuthResponse a partir do JSON
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['access_token'] as String,
      user: User.fromJson(json['user']),
    );
  }
  
  
}