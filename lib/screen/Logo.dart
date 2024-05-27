import 'dart:async';

import 'package:control_gastos/main.dart';
import 'package:control_gastos/screen/Login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Logo extends StatefulWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  _LogoState createState() => _LogoState();
}

class _LogoState extends State<Logo> with SingleTickerProviderStateMixin {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: 3), () {
      // Navegar a la nueva pantalla después de 3 segundos
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Login()),
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancelar el temporizador para liberar recursos
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.trending_up, size: 100,),
            Text(
              'Gasto Personal', 
              style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 60, 238, 152),
    );
  }
}

class OtraPantalla extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Otra Pantalla'),
      ),
      body: Center(
        child: Text('Esta es otra pantalla'),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Logo(),
    );
  }
}
