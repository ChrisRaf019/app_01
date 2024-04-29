import 'package:control_gastos/components/CustomButton.dart';
import 'package:control_gastos/components/CustomTextField.dart';
import 'package:control_gastos/screen/Home.dart';
import 'package:control_gastos/screen/Register.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

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
          alignment: Alignment.center,
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
              const CustomTextField(
                  title: "Correo", hintText: 'example@example.com'),
              const CustomTextField(title: "Contraseña", hintText: 'xxxxxxxxx'),
              CustomButton(
                title: "Iniciar Sesión",
                bgColor: Color.fromARGB(255, 60, 238, 152),
                textColor: Colors.black,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
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
                bgColor: Color.fromARGB(255, 60, 238, 152),
                textColor: Colors.black,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Register()),
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
                  Icon(Icons.iron_sharp, size: 60.0)
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}