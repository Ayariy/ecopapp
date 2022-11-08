import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:ecop_app/utils/Alerta.dart';
import "package:flutter/material.dart";
import 'package:appcheck/appcheck.dart';
import 'package:path_provider/path_provider.dart' as p;

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_installer/app_installer.dart';

class TourPage extends StatefulWidget {
  const TourPage({super.key});

  @override
  State<TourPage> createState() => _TourPageState();
}

class _TourPageState extends State<TourPage> {
  String _fileFullPath = '';

  final urlApk =
      "https://firebasestorage.googleapis.com/v0/b/ecoapp-98f4c.appspot.com/o/Ecoparque.apk?alt=media&token=06497311-8fc6-4adb-9143-ef83f1f4ee7c";
  void _downLoadFile() async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      final baseStorage = await p.getExternalStorageDirectory();
      // await FlutterDownloader.cancelAll();
      final id = await FlutterDownloader.enqueue(
          url: urlApk,
          savedDir: baseStorage!.path,
          fileName: "Tour Ecoparque APP");
      print(id.toString());
    } else {
      getAlert(context, "Error en los permisos",
          "Se necesitan aceptar los permisos para continuar");
    }
  }

  int progreso = 0;
  ReceivePort receivePort = ReceivePort();
  @override
  void initState() {
    // TODO: implement initState
    IsolateNameServer.registerPortWithName(
        receivePort.sendPort, "DescargandoTour APK");
    receivePort.listen((message) {
      if (mounted) {
        setState(() {
          progreso = message;
        });
      }
    });
    FlutterDownloader.registerCallback(downloadFunction);
    super.initState();
  }

  static downloadFunction(id, status, progress) {
    SendPort? sendPort =
        IsolateNameServer.lookupPortByName("DescargandoTour APK");
    sendPort?.send(progress);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('Tour Ecoparque')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              child: Text(
                  'Disfruta de un recorrido virtual en el Ecoparque con nuestra Aplicación'),
            ),
            Image.asset(
              'assets/imgEcoparque.JPG',
              fit: BoxFit.cover,
              width: size.height * 0.37,
              height: size.height * 0.37,
            ),
            MaterialButton(
              color:
                  Theme.of(context).floatingActionButtonTheme.backgroundColor,
              textColor: Theme.of(context).appBarTheme.foregroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () async {
                AppInfo? app =
                    await AppCheck.checkAvailability("com.Ecop.Ecoparque")
                        .onError((error, stackTrace) => null);
                if (app == null) {
                  String pathFile =
                      (await p.getExternalStorageDirectory())!.path +
                          "/Tour Ecoparque APP";
                  File file = File(pathFile);
                  if (await file.exists()) {
                    AppInstaller.installApk(pathFile);
                  } else {
                    getAlert(context, "Descargando",
                        "No está instalado la Apliación Tour, Esperé mientras finaliza la descarga");
                    _downLoadFile();
                  }
                } else {
                  AppCheck.launchApp("com.Ecop.Ecoparque");
                }
                // List<AppInfo>? installedApps = await AppCheck.getInstalledApps();
                // for (AppInfo element in installedApps!) {
                //   print(element.);
                // }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.gamepad_outlined),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Ejecutar Tour Ecoparque")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
