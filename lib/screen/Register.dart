import 'package:control_gastos/screen/Login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:control_gastos/components/CustomButton.dart';
import 'package:control_gastos/components/CustomTextField.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  // Validador básico para campos obligatorios
  String? _validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu $fieldName';
    }
    return null;
  }

  Future<void> _registro() async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: _emailController.text, password: _passController.text);
      // Si el registro es exitoso, podrías navegar a la pantalla de inicio
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    } catch (e) {
      // Si hay algún error en el registro, imprime el error
      print('Error al registrarse: $e');
    }
  }

  // Estado para verificar si se debe mostrar el mensaje de campos obligatorios
  bool _showRequiredMessage = false;

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
              topLeft: Radius.circular(50),
              topRight: Radius.circular(59),
            ),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomTextField(
                  title: "Nombre y Apellido",
                  hintText: 'Juan Perez',
                  controller: _nameController,
                  validator: (value) =>
                      _validateNotEmpty(value, 'nombre y apellido'),
                ),
                CustomTextField(
                  title: "Email",
                  hintText: 'example@example.com',
                  controller: _emailController,
                  validator: (value) =>
                      _validateNotEmpty(value, 'correo electrónico'),
                ),
                CustomTextField(
                  title: "Número",
                  hintText: '+595 971 456 789',
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                ),
                CustomTextField(
                  title: "Fecha de Nacimiento",
                  hintText: 'DD / MM / YY',
                  controller: _birthDateController,
                ),
                CustomTextField(
                  title: "Contraseña",
                  hintText: '********',
                  controller: _passController,
                  obscureText: true,
                  validator: (value) => _validateNotEmpty(value, 'contraseña'),
                ),
                CustomTextField(
                  title: "Confirmar contraseña",
                  hintText: '********',
                  controller: _confirmPassController,
                  obscureText: true,
                  validator: (value) {
                    if (value != _passController.text) {
                      return 'Las contraseñas no coinciden';
                    }
                    return null;
                  },
                ),
                if (_showRequiredMessage)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Center(
                      child: Text(
                        'Por favor complete todos los campos obligatorios.',
                        style: TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
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
                    setState(() {
                      _showRequiredMessage = false;
                    });
                    if (_nameController.text.isEmpty ||
                        _emailController.text.isEmpty ||
                        _passController.text.isEmpty ||
                        _confirmPassController.text.isEmpty) {
                      setState(() {
                        _showRequiredMessage = true;
                      });
                      return;
                    }
                    _registro();
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Ya tienes una cuenta? '),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
                      },
                      child: const Text(
                        "Iniciar sesión aquí",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
