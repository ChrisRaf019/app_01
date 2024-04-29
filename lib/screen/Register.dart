import 'package:control_gastos/components/CustomButton.dart';
import 'package:control_gastos/components/CustomTextField.dart';
import 'package:control_gastos/screen/Home.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 60, 238, 152),
        appBar: AppBar(
          toolbarHeight: 200,
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: const Text(
            'Registrarse',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color.fromARGB(255, 60, 238, 152),
        ),
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(59)),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const CustomTextField(
                  title: "Nombre Y Apellido", hintText: 'Juan Perez'),
              const CustomTextField(
                  title: "Email", hintText: 'example@example.com'),
              const CustomTextField(
                  title: "Numero", hintText: '+595 971 456 789'),
              const CustomTextField(
                  title: "Fecha De Nacimiento", hintText: 'DD / MM / YY'),
              const CustomTextField(
                  title: "Contraseña  ", hintText: 'example@example.com'),
              const CustomTextField(
                  title: "Confirmar contraseña",
                  hintText: 'example@example.com'),
              const Center(
                child: Text(
                  "Al continuar, usted acepta los",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const Center(
                child: Text(
                  "Términos y Condiciones",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CustomButton(
                title: "Registrarme",
                bgColor: Color.fromARGB(255, 60, 238, 152),
                textColor: Colors.black,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                },
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Ya tienes una cuenta? '),
                  Text("Iniciar sesion aqui",
                      style: TextStyle(color: Colors.blue))
                ],
              )
            ],
          )),
        ),
      ),
    );
  }
}