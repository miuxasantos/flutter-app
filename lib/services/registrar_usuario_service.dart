import 'package:dio/dio.dart';
import 'package:flutter_school/model/response_cadastrar_usuario_dto.dart';
import 'package:flutter_school/utils/constants_api.dart';


class RegistrarUsuarioService {
  final dio = new Dio();

  Future<ResponseCadastrarUsuarioDto> registrarUsuario(
    String name,
    String email,
    String password,
  ) async {
    try {
      final response = await dio.post(ConstantsApi.baseUrl + ConstantsApi.porta + ConstantsApi.baseApi + ConstantsApi.urlRegistrarUsuario, data: { 
        "name": name,
        "email": email,
        "password": password,
      });
      return ResponseCadastrarUsuarioDto.fromJson(response.data);
    } on DioException catch (e) {
      if(e.response!.statusCode == 400) {
        return ResponseCadastrarUsuarioDto(message: e.response!.data['message']);
      } else if (e.response!.statusCode == 500) {
        return ResponseCadastrarUsuarioDto(message: "Erro no servidor. Tente novamente mais tarde.");
      } else {
        return ResponseCadastrarUsuarioDto(message: e.toString());
      }
    }
  }
}