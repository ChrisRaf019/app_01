import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SimpleBarChart extends StatelessWidget {
  final List<SalesData> data;

  SimpleBarChart({required this.data});

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      [
        charts.Series(
          id: 'Ganancias',
          data: data,
          domainFn: (dynamic sales, _) => (sales as SalesData).year,
          measureFn: (dynamic sales, _) => (sales as SalesData).sales,
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          labelAccessorFn: (dynamic sales, _) => '\$${(sales as SalesData).sales.toString()}',
        ),
      ],
      animate: true,
    );
  }
}

class SalesData {
  final String year;
  final int sales;

  SalesData(this.year, this.sales);
}
