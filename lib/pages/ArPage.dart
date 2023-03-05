import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import "package:flutter/material.dart";
import 'package:app_installer/app_installer.dart';
import 'package:appcheck/appcheck.dart';
import 'package:path_provider/path_provider.dart' as p;

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_installer/app_installer.dart';

import '../utils/Alerta.dart';

class ArPage extends StatefulWidget {
  const ArPage({super.key});

  @override
  State<ArPage> createState() => _ArPageState();
}

class _ArPageState extends State<ArPage> {
  String _fileFullPath = '';

  final urlApk =
      "https://firebasestorage.googleapis.com/v0/b/ecoapp-98f4c.appspot.com/o/EcopAR.apk?alt=media&token=bc8de162-5bf5-406f-b856-a99daaa61776";

  void _downLoadFile() async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      final baseStorage = await p.getExternalStorageDirectory();
      final id = await FlutterDownloader.enqueue(
          url: urlApk,
          savedDir: baseStorage!.path,
          fileName: "AR Ecoparque APP");
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
        receivePort.sendPort, "DescargandoAR");
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
    SendPort? sendPort = IsolateNameServer.lookupPortByName("DescargandoAR");
    sendPort?.send(progress);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Realidad Aumentada Ecoparque')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              child: Text(
                  'Escanea los diferentes marcadores, para visualizar los diferentes animales, atravéz de Realidad Aumentada'),
            ),
            Image.asset(
              'assets/imgAREcop.JPG',
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
                    await AppCheck.checkAvailability("com.EcopAR.EcopAR")
                        .onError((error, stackTrace) => null);
                if (app == null) {
                  String pathFile =
                      (await p.getExternalStorageDirectory())!.path +
                          "/AR Ecoparque APP";
                  File file = File(pathFile);
                  if (await file.exists()) {
                    AppInstaller.installApk(pathFile);
                  } else {
                    getAlert(context, "Descargando",
                        "No está instalada la Apliación de Realidad Aumentada, Esperé mientras finaliza la descarga");
                    _downLoadFile();
                  }
                } else {
                  AppCheck.launchApp("com.EcopAR.EcopAR");
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
                  Text("Ejecutar Ecoparque AR")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


// com.EcopAR.EcopAR