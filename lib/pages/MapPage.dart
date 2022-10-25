import 'package:appcheck/appcheck.dart';
import 'package:ecop_app/utils/Alerta.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapController mapController = MapController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('¡Encuéntranos!')),
      body: SizedBox(
        child: FlutterMap(
          mapController: mapController,
          options: MapOptions(
              center: LatLng(0.8277560938412293, -77.76812089979414),
              zoom: 10,
              maxZoom: 19.0,
              minZoom: 5.0),
          // nonRotatedChildren: [
          //   AttributionWidget.defaultWidget(
          //     source: 'OpenStreetMap contributors',
          //     onSourceTapped: null,
          //   ),
          // ],
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(0.8277560938412293, -77.76812089979414),
                  // width: 80,
                  // height: 80,
                  builder: (context) => Icon(Icons.location_on,
                      color: Colors.blueAccent, size: 45),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              child: Icon(Icons.my_location),
              onPressed: () {
                mapController.move(
                  LatLng(0.8277560938412293, -77.76812089979414),
                  10,
                );
              }),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
              child: Icon(Icons.map),
              onPressed: () {
                try {
                  AppCheck.launchApp("com.google.android.apps.maps");
                } catch (e) {
                  getAlert(context, "Alerta",
                      "No está instalada la Aplicación de Google Maps");
                }
                // com.google.android.apps.maps
              })
        ],
      ),
    );
    ;
  }
}
