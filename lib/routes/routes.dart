import 'package:ecop_app/pages/ArPage.dart';
import 'package:ecop_app/pages/HomePage.dart';
import 'package:ecop_app/pages/MapPage.dart';
import 'package:ecop_app/pages/OlvidadoPage.dart';
import 'package:ecop_app/pages/TourPage.dart';
import 'package:ecop_app/pages/TresDObject.dart';
import 'package:ecop_app/pages/WrapPage.dart';
import 'package:ecop_app/pages/admin/HomeAdminPage.dart';
import 'package:flutter/material.dart';
import 'package:ecop_app/pages/LoginPage.dart';
import 'package:ecop_app/pages/RegistroPage.dart';

Map<String, WidgetBuilder> getAplicationRoutes() {
  return <String, WidgetBuilder>{
    //DRAWER BAR PAGES

    'wrap': (context) => const WrapPage(),
    'home': (context) => const HomePage(),
    'login': (context) => LoginPage(),
    'registro': (context) => const RegistroPage(),
    'tour': (context) => const TourPage(),
    'ar': ((context) => const ArPage()),
    'olvidado': (context) => const OlvidadoPage(),
    'modelo3d': (context) => const TresDObject(),
    'map': (context) => const MapPage(),

    //administrador
    'admin': (context) => const HomeAdminPage(),
  };
}
