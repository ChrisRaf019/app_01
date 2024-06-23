import 'package:control_gastos/components/CustomButton.dart';
import 'package:control_gastos/screen/egresoChart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class EgresosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 60, 238, 152),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 60, 238, 152),
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Center(
            child: Text('Lista de Egresos', textAlign: TextAlign.center)),
      ),
      body: EgresosList(),
    );
  }
}

class EgresosList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('egresos').snapshots(),
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

            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: egresosDocs.length,
                    itemBuilder: (context, index) {
                      final egreso = egresosDocs[index];
                      final monto = egreso['monto'];
                      final motivo = egreso['motivo'];
                      final fecha = (egreso['date'] as Timestamp).toDate();
                      final formattedDate =
                          DateFormat('dd/MM/yyyy').format(fecha);

                      return Container(
                        margin: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.shopping_cart,
                              color: Colors.red),
                          title: Text(
                            'Monto: ${NumberFormat.currency(symbol: '', decimalDigits: 0, locale: 'es_PY').format(monto)} Gs.',
                          ),
                          subtitle:
                              Text('Motivo: $motivo\nFecha: $formattedDate'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    title: "Ver grafico",
                    bgColor: const Color.fromARGB(255, 255, 255, 255),
                    textColor: Colors.black,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EgresosChartScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
