import 'package:ecop_app/pages/admin/DashPage.dart';
import 'package:ecop_app/pages/admin/GraficsPage.dart';
import 'package:ecop_app/providers/AuthProvider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/UserProvider.dart';
import 'UsersAllPage.dart';

class HomeAdminPage extends StatefulWidget {
  const HomeAdminPage({super.key});

  @override
  State<HomeAdminPage> createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {
  int _paginaActual = 0;
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Administrador')),
      body: getPagina(authProvider),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              _paginaActual = value;
            });
          },
          currentIndex: _paginaActual,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.people,
                  color: Colors.black,
                ),
                label: ''),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.remove_red_eye,
                color: Colors.black,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart_sharp, color: Colors.black),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                label: '')
          ]),
    );
  }

  Widget getPagina(AuthProvider authProvider) {
    switch (_paginaActual) {
      case 0:
        return UsersAllPage();
      case 1:
        return DashPage();
      case 2:
        return GraficsPage();

      case 3:
        authProvider.logout();
        return Center(
          child: Column(
            children: const [
              CircularProgressIndicator(),
              Text('Cerrando sesión')
            ],
          ),
        );
      default:
        return DashPage();
    }
  }
}
