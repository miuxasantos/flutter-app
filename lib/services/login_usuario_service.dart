import 'package:dio/dio.dart';
import 'package:flutter_school/model/response_login_usuario_dto.dart';
import 'package:flutter_school/utils/constants_api.dart';


class LoginUsuarioService {
  final dio = new Dio();

  Future<ResponseLoginUsuarioDto> loginUsuario(
    String email,
    String password,
  ) async {
    try {
      final response = await dio.post(ConstantsApi.baseUrl + ConstantsApi.porta + ConstantsApi.baseApi + ConstantsApi.urlLoginUsuario, data: {
        "email": email,
        "password": password,
      });
      return ResponseLoginUsuarioDto.fromJson(response.data);
    } on DioException catch (e) {
      if(e.response!.statusCode == 400) {
        return ResponseLoginUsuarioDto(message: e.response!.data['message']);
      } else if (e.response!.statusCode == 500) {
        return ResponseLoginUsuarioDto(message: "Erro no servidor. Tente novamente mais tarde.");
      } else {
        return ResponseLoginUsuarioDto(message: e.toString());
      }
    }
  }
}