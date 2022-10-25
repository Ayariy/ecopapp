import 'package:ecop_app/models/ViewAnimals.dart';
import 'package:ecop_app/providers/ViewAnimalsProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DashPage extends StatefulWidget {
  const DashPage({super.key});

  @override
  State<DashPage> createState() => _DashPageState();
}

class _DashPageState extends State<DashPage> {
  bool isLoading = false;

  ViewAnimals viewAnimals = new ViewAnimals.userModelNoData();
  ViewAnimalsProvider viewAnimalsProvider = new ViewAnimalsProvider();
  final List<ViewAnimal> viewDataBar = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      _getViews();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: _getViews,
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                      'Cantidad de personas que han visto cada escultura animal',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                _getGraficos(),
                ListTile(
                  leading: Icon(Icons.remove_red_eye),
                  title: Text('Caiman'),
                  subtitle: Row(children: [
                    Text(viewAnimals.caiman.length.toString()),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(Icons.person),
                    const Text(' - Usuarios')
                  ]),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.remove_red_eye),
                  title: Text('Colibrí'),
                  subtitle: Row(children: [
                    Text(viewAnimals.colibri.length.toString()),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(Icons.person),
                    const Text(' - Usuarios')
                  ]),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.remove_red_eye),
                  title: Text('Jaguar'),
                  subtitle: Row(children: [
                    Text(viewAnimals.jaguar.length.toString()),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(Icons.person),
                    const Text(' - Usuarios')
                  ]),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.remove_red_eye),
                  title: Text('Lagartija'),
                  subtitle: Row(children: [
                    Text(viewAnimals.lagartija.length.toString()),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(Icons.person),
                    const Text(' - Usuarios')
                  ]),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.remove_red_eye),
                  title: Text('Murcielago'),
                  subtitle: Row(children: [
                    Text(viewAnimals.murcielago.length.toString()),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(Icons.person),
                    const Text(' - Usuarios')
                  ]),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.remove_red_eye),
                  title: Text('Oso'),
                  subtitle: Row(children: [
                    Text(viewAnimals.oso.length.toString()),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(Icons.person),
                    const Text(' - Usuarios')
                  ]),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.remove_red_eye),
                  title: Text('Perezoso'),
                  subtitle: Row(children: [
                    Text(viewAnimals.perezoso.length.toString()),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(Icons.person),
                    const Text(' - Usuarios')
                  ]),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.remove_red_eye),
                  title: Text('Rana'),
                  subtitle: Row(children: [
                    Text(viewAnimals.rana.length.toString()),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(Icons.person),
                    const Text(' - Usuarios')
                  ]),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.remove_red_eye),
                  title: Text('Tortuga'),
                  subtitle: Row(children: [
                    Text(viewAnimals.tortuga.length.toString()),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(Icons.person),
                    const Text(' - Usuarios')
                  ]),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.remove_red_eye),
                  title: Text('Venado'),
                  subtitle: Row(children: [
                    Text(viewAnimals.venado.length.toString()),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(Icons.person),
                    const Text(' - Usuarios')
                  ]),
                ),
              ],
            ),
    ));
  }

  Future<void> _getViews() async {
    isLoading = true;
    viewAnimals = await viewAnimalsProvider.getViewsAnimals();

    viewDataBar.add(ViewAnimal(animal: 'Cai', view: viewAnimals.caiman.length));
    viewDataBar
        .add(ViewAnimal(animal: 'Col', view: viewAnimals.colibri.length));
    viewDataBar.add(ViewAnimal(animal: 'Jag', view: viewAnimals.jaguar.length));
    viewDataBar
        .add(ViewAnimal(animal: 'Lag', view: viewAnimals.lagartija.length));
    viewDataBar
        .add(ViewAnimal(animal: 'Mur', view: viewAnimals.murcielago.length));
    viewDataBar.add(ViewAnimal(animal: 'Oso', view: viewAnimals.oso.length));
    viewDataBar
        .add(ViewAnimal(animal: 'Per', view: viewAnimals.perezoso.length));
    viewDataBar.add(ViewAnimal(animal: 'Ran', view: viewAnimals.rana.length));
    viewDataBar
        .add(ViewAnimal(animal: 'Tor', view: viewAnimals.tortuga.length));
    viewDataBar.add(ViewAnimal(animal: 'Ven', view: viewAnimals.venado.length));

    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  _getGraficos() {
    List<charts.Series<ViewAnimal, String>> series = [
      charts.Series<ViewAnimal, String>(
          id: 'DataLineal',
          domainFn: (viewAnimal, entero) => viewAnimal.animal,
          measureFn: (viewAnimal, entero) => viewAnimal.view,
          data: viewDataBar,
          seriesColor: charts.ColorUtil.fromDartColor(Colors.yellow),
          colorFn: (eventoDia, entero) {
            if (Theme.of(context).brightness == Brightness.light) {
              return charts.ColorUtil.fromDartColor(
                  Theme.of(context).primaryColor);
            } else {
              return charts.ColorUtil.fromDartColor(
                  Theme.of(context).textTheme.bodyText2!.color!);
            }
          })
    ];

    return Container(
      height: 150,
      width: 220,
      child: charts.BarChart(
        series,
        // primaryMeasureAxis: axisMeasureInt,
        // domainAxis: axisDomainString,
        defaultRenderer: charts.BarRendererConfig(
            cornerStrategy: const charts.ConstCornerStrategy(5)),
      ),
    );
  }
}

class ViewAnimal {
  String animal;
  int view;
  ViewAnimal({required this.animal, required this.view});
}
