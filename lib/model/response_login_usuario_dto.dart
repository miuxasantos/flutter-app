class ResponseLoginUsuarioDto {
  String? message;
  String? error;
  int? statusCode;
  String? id;
  String? name;
  String? email;
  String? token;

  ResponseLoginUsuarioDto(
      {this.message,
      this.error,
      this.statusCode,
      this.id,
      this.name,
      this.email,
      this.token});

  ResponseLoginUsuarioDto.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    statusCode = json['statusCode'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    data['statusCode'] = this.statusCode;
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['token'] = this.token;
    return data;
  }
}
