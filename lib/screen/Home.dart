import 'package:flutter/material.dart';
import 'package:control_gastos/screen/egresos.dart';
import 'package:control_gastos/screen/ingresos.dart';
import 'package:control_gastos/components/Graphic.dart';
import 'package:control_gastos/components/CustomButton.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 60, 238, 152),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 40, left: 15, right: 15),
                padding: const EdgeInsets.all(20.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hola, Bienvenido',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.notifications_rounded, size: 30)
                  ],
                ),
              ),
              Container(
                height: 100,
                padding: const EdgeInsets.all(20.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.arrow_outward, size: 18),
                            Text("Balance Total")
                          ],
                        ),
                        Text("Gs7,783,00",
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white))
                      ],
                    ),
                    VerticalDivider(width: 10, color: Colors.black),
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.arrow_outward, size: 18),
                            Text("Balance Total")
                          ],
                        ),
                        Text("-Gs1,187.40",
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue))
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              topLeft: Radius.circular(20))),
                      child: const Center(
                        child:
                            Text("30%", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: const Center(
                        child: Text("Gs20,000.00"),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 400,
                margin: const EdgeInsets.all(20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40.0),
                ),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 60, 238, 152),
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text("Diaria"))),
                          const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text("Semanal")),
                          const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text("Mensual")),
                          const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text("Anual"))
                        ],
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.only(top: 20, bottom: 10),
                        height: 220,
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SimpleBarChart(
                          data: [
                            SalesData('2016', 100),
                            SalesData('2017', 75),
                            SalesData('2018', 150),
                            SalesData('2019', 200),
                          ],
                        )),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.arrow_outward, size: 18),
                            Text("Ingreso",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("Gs4,120.00",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold))
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.arrow_outward, size: 18),
                            Text("Gastos",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("Gs1.187.40",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue))
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 60,
          decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
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
                onPressed: () {},
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
      ),
    );
  }
}
