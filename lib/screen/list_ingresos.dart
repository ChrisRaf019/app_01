import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class IngresosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Ingresos'),
      ),
      body: IngresosList(),
    );
  }
}

class IngresosList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('ingresos').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No hay egresos registrados.'));
        }

        final egresosDocs = snapshot.data!.docs;

        return ListView.builder(
          itemCount: egresosDocs.length,
          itemBuilder: (context, index) {
            final egreso = egresosDocs[index];
            final monto = egreso['monto'];
            final motivo = egreso['motivo'];
            final fecha = (egreso['date'] as Timestamp).toDate();
            final formattedDate = DateFormat('dd/MM/yyyy').format(fecha);

            return ListTile(
              leading: const Icon(Icons.shopping_cart, color: Colors.red), 
              title: Text('Monto: ${NumberFormat.currency(symbol: '', decimalDigits: 0, locale: 'es_PY').format(monto)} Gs.'),
              subtitle: Text('Motivo: $motivo\nFecha: $formattedDate'),
            );
          },
        );
      },
    );
  }
}