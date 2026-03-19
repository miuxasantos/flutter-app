import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegistrarUsuario extends StatefulWidget {
  const RegistrarUsuario({super.key});

  @override
  State<RegistrarUsuario> createState() => _MyWidgetState();
  
}

class _MyWidgetState extends State<RegistrarUsuario> {
  final _formKey = GlobalKey<FormState>();

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
        title: Row(
          children: [
            FaIcon(FontAwesomeIcons.userPlus, color: Colors.black,),
            SizedBox(width: 10),
            Text("Registrar Usuário", 
                style: TextStyle(color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
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
                  Text("Registrar Uusário"),
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
                    child: ElevatedButton.icon(onPressed:  () {
                      if (!_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Verifique o formulário"), backgroundColor: Colors.red,),
                        );
                      }
                    }, 
                      icon: FaIcon(FontAwesomeIcons.userPlus, size: 20,),
                      label: Text("Registrar", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}