import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class EgresosChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gráfico de Egresos'),
      ),
      body: EgresosChart(),
    );
  }
}

class EgresosChart extends StatelessWidget {
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

        // Procesar los datos
        Map<String, double> egresosMap = {};
        for (var doc in egresosDocs) {
          final fecha = (doc['date'] as Timestamp).toDate();
          final formattedDate = DateFormat('dd/MM/yyyy').format(fecha);
          final monto = doc['monto'] as int;

          if (egresosMap.containsKey(formattedDate)) {
            egresosMap[formattedDate] = egresosMap[formattedDate]! + monto;
          } else {
            egresosMap[formattedDate] = monto.toDouble();
          }
        }

        // Convertir los datos a un formato adecuado para el gráfico de barras
        final sortedKeys = egresosMap.keys.toList()
          ..sort((a, b) => DateFormat('dd/MM/yyyy')
              .parse(a)
              .compareTo(DateFormat('dd/MM/yyyy').parse(b)));
        List<BarChartGroupData> barGroups = [];
        for (var i = 0; i < sortedKeys.length; i++) {
          barGroups.add(BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: egresosMap[sortedKeys[i]]!,
                color: Colors.blue,
                width: 16,
                borderRadius: BorderRadius.circular(4),
              )
            ],
          ));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              barGroups: barGroups,
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      if (value.toInt() < 0 ||
                          value.toInt() >= sortedKeys.length) {
                        return const SizedBox.shrink();
                      }
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Text(
                          sortedKeys[value.toInt()],
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      );
                    },
                    interval: 1,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      );
                    },
                    interval: 200, // Ajustar el intervalo según los datos
                  ),
                ),
              ),
              borderData: FlBorderData(show: true),
              gridData: FlGridData(show: true),
            ),
          ),
        );
      },
    );
  }
}
