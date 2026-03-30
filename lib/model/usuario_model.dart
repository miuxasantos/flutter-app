class UsuarioModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String? token;

  UsuarioModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.token,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      id: json['id'] ?? json['sub'] ?? '',
      name: json['name'],
      email: json['email'],
      role: json['role'] ?? 'usuario',
      token: json['access_token'],
    );
  }
}