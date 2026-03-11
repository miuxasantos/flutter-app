import 'package:flutter/material.dart';

class Alinhamento extends StatelessWidget {
  const Alinhamento({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Alinhamento"),
            SizedBox(
              width: 20,
            ),
            Text("Olá"),
            SizedBox(
              width: 20,
            ),
            Text("Mundo"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}