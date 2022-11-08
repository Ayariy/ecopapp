import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:ecop_app/providers/AdminProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GraficsPage extends StatefulWidget {
  const GraficsPage({super.key});

  @override
  State<GraficsPage> createState() => _GraficsPageState();
}

class _GraficsPageState extends State<GraficsPage> {
  AdminProvider admin = AdminProvider();
  List listUsers = [];

  final List<ViewPais> viewUserPais = [];
  final List<ViewCiudad> viewUserCiudad = [];
  final List<ViewEdad> viewUserEdad = [];
  final List<ViewValoracion> viewUserValoracion = [];

  bool isLoading = false;
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
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  const Text(
                    'Usuarios de diferentes paises',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  _getGraficosPais(),
                  const Divider(),
                  const Text(
                    'Usuarios de diferentes ciudades',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  _getGraficosCiudad(),
                  const Divider(),
                  const Text(
                    'Usuarios de diferentes edades',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  _getGraficosEdad(),
                  const Divider(),
                  const Text(
                    'Estadisticas de la valoración',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  _getGraficosValoracion()
                ],
              ),
            ),
    ));
  }

  void _getViewsUserEdad() async {
    isLoading = true;

    viewUserEdad.add(ViewEdad(
        rangoEdad: '.. - 10',
        numero: listUsers.where((item) => item.edad < 10).length));
    viewUserEdad.add(ViewEdad(
        rangoEdad: '10 - 15',
        numero: listUsers
            .where((item) => item.edad >= 10 && item.edad <= 15)
            .length));
    viewUserEdad.add(ViewEdad(
        rangoEdad: '16 - 20',
        numero: listUsers
            .where((item) => item.edad >= 16 && item.edad <= 20)
            .length));
    viewUserEdad.add(ViewEdad(
        rangoEdad: '21 - 30',
        numero: listUsers
            .where((item) => item.edad >= 21 && item.edad <= 30)
            .length));

    viewUserEdad.add(ViewEdad(
        rangoEdad: '31 - 45',
        numero: listUsers
            .where((item) => item.edad >= 31 && item.edad <= 45)
            .length));

    viewUserEdad.add(ViewEdad(
        rangoEdad: '46 - ..',
        numero: listUsers.where((item) => item.edad >= 46).length));

    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  void _getViewsUserCiudad() async {
    isLoading = true;

    var listAuxGroup = listUsers.groupListsBy(
      (element) {
        return element!.ciudad;
      },
    );

    int limiteGrafico = 6;
    // if (listAuxGroup.keys.length <= limiteGrafico) {
    //   //hago sin recortar los estadisticas directamente
    // } else {
    var sortMapUser = SplayTreeMap<dynamic, List<dynamic>>.from(
      listAuxGroup,
      (key1, key2) {
        var valueA = listAuxGroup[key1]?.length;
        var valueB = listAuxGroup[key2]?.length;
        if (valueA != null && valueB != null) {
          var result = valueB.compareTo(valueA);
          if (result != 0) {
            return result;
          }
        }
        return key2.compareTo(key1);
        // return listAuxGroup[key2]!.length.compareTo(listAuxGroup[key1]!.length);
      },
    );

    var MapToBarView = Map.from(sortMapUser);
    for (var i = 0; i < sortMapUser.keys.toList().length; i++) {
      if (i >= limiteGrafico) {
        MapToBarView.remove(sortMapUser.keys.toList()[i]);
      }
    }
    //Los primeros 10 mas vistos

    MapToBarView.forEach((key, value) {
      viewUserCiudad
          .add(ViewCiudad(ciudad: key.toString(), numero: value.length));
    });

    // print(viewUserCiudad.length);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  void _getViewsUserPais() async {
    isLoading = true;

    viewUserPais.add(ViewPais(
        pais: 'Ecu',
        numero: listUsers.where((item) => item.pais == 'Ecuador').length));
    viewUserPais.add(ViewPais(
        pais: 'Col',
        numero: listUsers.where((item) => item.pais == 'Colombia').length));
    viewUserPais.add(ViewPais(
        pais: 'Otr',
        numero: listUsers.where((item) => item.pais == 'Otro').length));

    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  void _getViewsUserValoracion() async {
    isLoading = true;

    listUsers.forEach((element) {
      element.valoracion = element.valoracion.round().toDouble();
    });

    var listAuxGroup = listUsers.groupListsBy(
      (element) {
        return element!.valoracion;
      },
    );

    int limiteGrafico = 6;
    var sortMapUser = SplayTreeMap<dynamic, List<dynamic>>.from(
      listAuxGroup,
      (key1, key2) {
        var valueA = listAuxGroup[key1]?.length;
        var valueB = listAuxGroup[key2]?.length;
        if (valueA != null && valueB != null) {
          var result = valueB.compareTo(valueA);
          if (result != 0) {
            return result;
          }
        }
        return key2.compareTo(key1);
        // return listAuxGroup[key2]!.length.compareTo(listAuxGroup[key1]!.length);
      },
    );

    var MapToBarView = Map.from(sortMapUser);
    for (var i = 0; i < sortMapUser.keys.toList().length; i++) {
      if (i >= limiteGrafico) {
        MapToBarView.remove(sortMapUser.keys.toList()[i]);
      }
    }
    //Los primeros 10 mas vistos

    MapToBarView.forEach((key, value) {
      viewUserValoracion.add(
          ViewValoracion(valoracion: key.toString(), numero: value.length));
    });

    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _getViews() async {
    listUsers = await admin.getAllUsuarios();
    _getViewsUserPais();
    _getViewsUserCiudad();
    _getViewsUserEdad();
    _getViewsUserValoracion();
  }

  _getGraficosPais() {
    List<charts.Series<ViewPais, String>> series = [
      charts.Series<ViewPais, String>(
          id: 'DataLineal',
          domainFn: (viewPais, entero) => viewPais.pais,
          measureFn: (viewPais, entero) => viewPais.numero,
          data: viewUserPais,
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

  _getGraficosCiudad() {
    List<charts.Series<ViewCiudad, String>> series = [
      charts.Series<ViewCiudad, String>(
          id: 'DataLineal',
          domainFn: (viewCiudad, entero) => viewCiudad.ciudad,
          measureFn: (viewCiudad, entero) => viewCiudad.numero,
          data: viewUserCiudad,
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

  _getGraficosEdad() {
    List<charts.Series<ViewEdad, String>> series = [
      charts.Series<ViewEdad, String>(
          id: 'DataLineal',
          domainFn: (viewEdad, entero) => viewEdad.rangoEdad,
          measureFn: (viewEdad, entero) => viewEdad.numero,
          data: viewUserEdad,
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

  _getGraficosValoracion() {
    List<charts.Series<ViewValoracion, String>> series = [
      charts.Series<ViewValoracion, String>(
          id: 'DataLineal',
          domainFn: (viewValoracion, entero) => viewValoracion.valoracion,
          measureFn: (viewValoracion, entero) => viewValoracion.numero,
          data: viewUserValoracion,
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

class ViewPais {
  String pais;
  int numero;
  ViewPais({required this.pais, required this.numero});
}

class ViewCiudad {
  String ciudad;
  int numero;
  ViewCiudad({required this.ciudad, required this.numero});
}

class ViewValoracion {
  String valoracion;
  int numero;
  ViewValoracion({required this.valoracion, required this.numero});
}

class ViewEdad {
  String rangoEdad;
  int numero;
  ViewEdad({required this.rangoEdad, required this.numero});
}
