import 'package:control_gastos/components/CustomButton.dart';
import 'package:control_gastos/components/CustomTextField.dart';
import 'package:control_gastos/screen/Home.dart';
import 'package:control_gastos/screen/Register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _mensaje = "";

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passController = TextEditingController();

  String Message(String text) {
    return text;
  }

  Future<bool> iniciar() async {
    if (_emailController.text.isEmpty || _passController.text.isEmpty) {
      setState(() {
        _mensaje = "Por favor, completa todos los campos.";
      });
      return false;
    }

    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
              email: _emailController.text, password: _passController.text);
      // Si el inicio de sesión es exitoso, retorna true
      return true;
    } catch (e) {
      // Si hay algún error en el inicio de sesión, imprime el error y retorna false
      print('Error al iniciar sesión: $e');
      setState(() {
        _mensaje = "Error al iniciar sesión: $e";
      });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 60, 238, 152),
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 200,
          automaticallyImplyLeading: true,
          title: const Text(
            'Bienvenido',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color.fromARGB(255, 60, 238, 152),
        ),
        body: Container(
          alignment: Alignment.topCenter,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50)),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomTextField(
                    title: "Correo",
                    hintText: 'example@example.com',
                    controller: _emailController),
                CustomTextField(
                    title: "Contraseña",
                    hintText: 'xxxxxxxxx',
                    controller: _passController),
                if (_mensaje.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text(
                        _mensaje,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                CustomButton(
                  title: "Iniciar Sesión",
                  bgColor: const Color.fromARGB(255, 60, 238, 152),
                  textColor: Colors.black,
                  onPressed: () async {
                    if (await iniciar()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                      );
                    }
                  },
                ),
                CustomButton(
                  title: "Olvidaste tu contraseña?",
                  bgColor: Colors.white,
                  textColor: Colors.black,
                  onPressed: () {},
                ),
                CustomButton(
                  title: "Registrarse",
                  bgColor: const Color.fromARGB(255, 60, 238, 152),
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                ),
                CustomButton(
                  title: "or sign up with",
                  bgColor: Colors.white,
                  textColor: Colors.black54,
                  onPressed: () {},
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.facebook_sharp, size: 60.0),
                    Icon(Icons.add_to_drive, size: 60.0)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
