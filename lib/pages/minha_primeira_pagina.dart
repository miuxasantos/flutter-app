import 'package:flutter/material.dart';
import 'package:flutter_school/pages/alinhamento.dart';

class MinhaPrimeiraPagina extends StatelessWidget {
  const MinhaPrimeiraPagina({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Primeira Página'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('Minha Primeira Página',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue)
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text("Segundo texto"),
          SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
            onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Alinhamento()));}, 
          
          label: Text("Botão", style: TextStyle(color: Colors.white)),
              style:  ElevatedButton.styleFrom(
                elevation: 5,
                backgroundColor: Colors.green,
              ),
              icon: Icon(Icons.login, color: Colors.white),
          ),
        ],
      ),
    );
  }
}