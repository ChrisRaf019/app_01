import 'package:control_gastos/components/CustomButton.dart';
import 'package:control_gastos/components/CustomTextField.dart';
import 'package:control_gastos/screen/Home.dart';
import 'package:control_gastos/screen/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
   Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
//instanciar con firebase
 final FirebaseAuth _auth = FirebaseAuth.instance;

 final TextEditingController _emailController = TextEditingController();

 final TextEditingController _passController = TextEditingController();

//
Future registro() async{
  print("llamar funcion");
  try {
    final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: _emailController.text, 
      password: _passController.text
      );
      //si el registro es exitoso inicia sesion
      // Navigator.pushNamed(context, 'Home');
  } catch (e) {
    //si el registro no es correcto
    print('Error al registrarse: $e');
  }
}

//
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
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(59)),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomTextField(
                  title: "Nombre Y Apellido", hintText: 'Juan Perez' ),
              CustomTextField(
                  title: "Email", hintText: 'example@example.com', controller: _emailController),
              CustomTextField(
                  title: "Numero", hintText: '+595 971 456 789'),
              CustomTextField(
                  title: "Fecha De Nacimiento", hintText: 'DD / MM / YY'),
              CustomTextField(
                  title: "Contraseña  ", hintText: 'example@example.com', controller: _passController),
              CustomTextField(
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
                  registro();
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