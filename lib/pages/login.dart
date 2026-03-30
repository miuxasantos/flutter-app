import 'package:flutter/material.dart';
import 'package:flutter_school/pages/registrar_usuario.dart';
import 'package:flutter_school/services/login_usuario_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginUsuarioService = LoginUsuarioService();
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool _isLoading = false;

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.yellow],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage('assets/miku2.webp'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.pink, width: 2),
                          ),
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon: FaIcon(FontAwesomeIcons.solidEnvelope),
                          ),
                          suffixIcon: IconButton(onPressed: () {
                            _emailController.clear();
                          },
                            icon: FaIcon(FontAwesomeIcons.xmark, color: Colors.red,)
                          )
                        ),
                        validator: (value) {
                          if(value == null || value.isEmpty) {
                            return 'Por favor, insira seu email';
                          } else if (!value.contains('@') || !value.contains('.')) {
                            return 'Por favor, insira um email válido';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                          ),
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon: FaIcon(FontAwesomeIcons.lock),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            icon: FaIcon(_isObscure ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye)
                          )
                        ),
                        validator: (value) {
                          if(value == null || value.isEmpty) {
                            return 'Por favor, insira sua senha';
                          } else if(value.length < 6) {
                            return 'A senha deve conter no mínimo 6 caracteres';
                          }
                          return null;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrarUsuario()));
                            },
                            child:
                              Text("Não possui cadastro? Clique aqui!", 
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold
                              ),
                              ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _isLoading ? null : () async {
                            if(!_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Verique o formulário! Email ou senha não podem ficar vazios."), backgroundColor: Colors.red, duration: Duration(seconds: 2))
                              );
                            } else {
                              setState(() {
                                _isLoading = true;
                              });

                              var response = await _loginUsuarioService.loginUsuario(
                                _emailController.text, 
                                _passwordController.text
                              );

                              if(response.message == null || response.message!.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Login realizado com sucesso"), backgroundColor: Colors.green,)
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Erro ao realizar login: ${response.message}"), backgroundColor: Colors.red,)
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
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                          iconAlignment: IconAlignment.end,
                        ),
                      )
                    ],
                  ),
                )
              )
            ],
          )
        ),
      ),
    );
  }
}