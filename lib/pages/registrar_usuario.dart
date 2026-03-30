import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_school/services/registrar_usuario_service.dart';

class RegistrarUsuario extends StatefulWidget {
  const RegistrarUsuario({super.key});

  @override
  State<RegistrarUsuario> createState() => _RegistrarUsuarioState();
  
}

class _RegistrarUsuarioState extends State<RegistrarUsuario> {
  final _formKey = GlobalKey<FormState>();
  final _registrarUsuarioService = RegistrarUsuarioService();
  bool _isLoading = false;

  TextEditingController _nomeController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController = new TextEditingController();

  bool _naoExibirSenha = true;
  bool _naoExibirConfirmacaoSenha = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registrar Usuário"),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.yellow],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Registrar Uusário", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                  SizedBox(height: 20),
                  TextFormField(
                      controller: _nomeController,
                      decoration: InputDecoration(
                        labelText: "Nome",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.user, color: Colors.black,)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Campo obrigatório";
                        } else if(value.length < 6) {
                          return "O nome deve conter no mínimo 6 caracteres";
                        }
                        return null;
                      },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      labelText: "Email",
                      prefixIcon: IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.solidEnvelope, color: Colors.black,)),
                      suffixIcon: IconButton(onPressed: () => _emailController.clear(),
                      icon: FaIcon(FontAwesomeIcons.circleXmark, color: Colors.red,)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Campo obrigatório";
                      } else if (!value.contains("@")) {
                        return "Email inválido";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _naoExibirSenha,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      labelText: "Senha",
                      prefixIcon: IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.lock, color: Colors.black,)),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _naoExibirSenha = !_naoExibirSenha;
                          });
                        },
                        icon: FaIcon(_naoExibirSenha ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye, color: Colors.black,),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Campo obrigatório";
                      } else if (value.length < 8) {
                        return "A senha deve conter no mínimo 8 caracteres";
                      } else if (value.contains("12345678")) {
                        return "A senha não pode conter sequências simples";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _naoExibirConfirmacaoSenha,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      labelText: "Confirmar Senha",
                      prefixIcon: IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.check, color: Colors.black,)),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _naoExibirConfirmacaoSenha = !_naoExibirConfirmacaoSenha;
                          });
                        },
                        icon: FaIcon(_naoExibirConfirmacaoSenha ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye, color: Colors.black,),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Campo obrigatório";
                      } else if (_confirmPasswordController.text != _passwordController.text) {
                        return "As senhas não coincidem";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton.icon(onPressed: _isLoading ? null : () async {
                      if (!_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Verifique o formulário"), backgroundColor: Colors.red,),
                        );
                      } else {
                        setState(() {
                          _isLoading = true;
                        });

                        var response = await _registrarUsuarioService.registrarUsuario(
                          _nomeController.text,
                          _emailController.text,
                          _passwordController.text,
                        );

                        if(response.message == null || response.message!.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Usuário registrado com sucesso"), backgroundColor: Colors.green,)
                          );
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Erro ao registrar usuário: ${response.message}"), backgroundColor: Colors.red,)
                          );
                      }
                      await Future.delayed(Duration(seconds: 5));
                      setState(() {
                        _isLoading = false; 
                      });
                    }

                    }, 
                    label: Text(
                      _isLoading ? "Registrando..." : "Registrar",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    icon: _isLoading ? CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      color: Colors.green,
                    ) : FaIcon(FontAwesomeIcons.userPlus, size: 20,),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                      ),
                      iconAlignment: IconAlignment.end,
                    )
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}