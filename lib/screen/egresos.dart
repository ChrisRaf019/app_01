import 'package:control_gastos/components/CustomButton.dart';
import 'package:control_gastos/components/CustomTextField.dart';
import 'package:control_gastos/screen/Home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

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
  final _formatter = NumberFormat("#,##0","es_ PY");

  Future<void> _submitData() async {
    if(!_formKey.currentState!.validate() || _selectedDate == null){
      return;
    }
    final monto = int.parse(_montoController.text.replaceAll('.', ''));
    final motivo = _motivoController.text;
    final fecha= _selectedDate!;

    await FirebaseFirestore.instance.collection('egresos').add({
      'monto': monto,
      'motivo': motivo,
      'date': fecha,
    });

    Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020), 
      lastDate: DateTime(2030),
    ).then((pickedDate){
      if (pickedDate == null){
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _formatAmount(String value) {
    if (value.isEmpty){
      _montoController.value=TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0)
      );
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Egreso'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Monto'),
                controller: _montoController,
                keyboardType: TextInputType.number,
                onChanged: _formatAmount,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Por favor ingrese un monto';
                  }
                  if(int.tryParse(value.replaceAll('.', ''))== null){
                    return 'Por favor ingrese un numero valido';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Motivo'),
                controller: _motivoController,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Por favor ingrese un motivio';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                      ? 'No se ha seleccionado una fecha'
                      : 'Fecha: ${_selectedDate!.toLocal()}'.split(' ')[0],
                    ),
                  ),
                  TextButton(
                    onPressed: _presentDatePicker, 
                    child: Text('Seleccionar Fecha'),
                  )
                ]
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitData,
                child: Text('Registrar Egreso')
              ),
            ],
          ),
        )
        ),
    );
  }
}