import 'package:control_gastos/screen/list_egresos.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:control_gastos/screen/Home.dart';
import 'package:control_gastos/screen/ingresos.dart';
import 'package:control_gastos/components/CustomButton.dart';
import 'package:control_gastos/components/CustomTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrarEgresos extends StatefulWidget {
  const RegistrarEgresos({super.key});

  @override
  State<RegistrarEgresos> createState() => _RegistrarEgresosState();
}

class _RegistrarEgresosState extends State<RegistrarEgresos> {
  final _formKey = GlobalKey<FormState>();
  final _montoController = TextEditingController();
  final _motivoController = TextEditingController();
  DateTime? _selectedDate;
  final _formatter = NumberFormat("#,##0", "es_ PY");

  Future<void> _submitData() async {
    if (!_formKey.currentState!.validate() || _selectedDate == null) {
      return;
    }
    final monto = int.parse(_montoController.text.replaceAll('.', ''));
    final motivo = _motivoController.text;
    final fecha = _selectedDate!;

    await FirebaseFirestore.instance.collection('egresos').add({
      'monto': monto,
      'motivo': motivo,
      'date': fecha,
    });

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _formatAmount(String value) {
    if (value.isEmpty) {
      _montoController.value = const TextEditingValue(
          text: '', selection: TextSelection.collapsed(offset: 0));
      return;
    }
    final newValue = value.replaceAll('.', '');
    final formattedValue = _formatter.format(int.parse(newValue));
    _montoController.value = TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }

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
              'Registrar Egresos',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            backgroundColor: const Color.fromARGB(255, 60, 238, 152),
          ),
          body: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(59)),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    CustomTextField(
                        title: "Ingrese el monto",
                        controller: _montoController,
                        keyboardType: TextInputType.number,
                        hintText: 'Monto',
                        onChanged: _formatAmount,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese un monto';
                          }
                          if (int.tryParse(value.replaceAll('.', '')) == null) {
                            return 'Por favor ingrese un numero valido';
                          }
                          return null;
                        }),
                    CustomTextField(
                        title: "Ingrese el motivo",
                        hintText: "motivo",
                        controller: _montoController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese un motivio';
                          }
                          return null;
                        }),
                    const SizedBox(height: 20),
                    Row(children: <Widget>[
                      Expanded(
                        child: Text(
                          _selectedDate == null
                              ? 'No se ha seleccionado una fecha'
                              : 'Fecha: ${DateFormat('dd/MM/yyyy HH:mm').format(_selectedDate!)}',
                        ),
                      ),
                      CustomButton(
                        title: 'Seleccionar Fecha',
                        textColor: Colors.black,
                        bgColor: const Color.fromARGB(255, 60, 238, 152),
                        onPressed: _presentDatePicker,
                        //child: Text('Seleccionar Fecha'),
                      ),
                    ]),
                    const SizedBox(height: 20),
                    CustomButton(
                      title: "Registrar Egreso",
                      bgColor: const Color.fromARGB(255, 60, 238, 152),
                      textColor: Colors.black,
                      onPressed: _submitData,
                    ),
                    CustomButton(
                      title: "Lista de Egresos",
                      bgColor: const Color.fromARGB(255, 60, 238, 152),
                      textColor: Colors.black,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EgresosScreen()),
                        );
                      },
                    ),
                  ],
                ),
              )),
          bottomNavigationBar: Container(
            height: 60,
            decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.south_east_rounded),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegistrarEgresos()),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.home),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.north_east_rounded),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegistrarIngresos()),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.person),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ));
  }
}
