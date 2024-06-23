import 'package:control_gastos/firebase_options.dart';
import 'package:control_gastos/screen/Logo.dart';
import 'package:control_gastos/screen/ingresoChart.dart';
import 'package:control_gastos/screen/ingresos.dart';
import 'package:control_gastos/screen/list_egresos.dart';
import 'package:control_gastos/screen/list_ingresos.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Logo(),
    );
  }
}
