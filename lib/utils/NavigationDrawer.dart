import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../providers/AuthProvider.dart';
import '../providers/UserProvider.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _getDrawerHeader(context),
            _getDrawerListView(context),
          ],
        ),
      ),
    );
  }

  Widget _getDrawerListView(BuildContext context) {
    final loginProvider = Provider.of<AuthProvider>(context);

    return Expanded(
      child: ListView(
        children: [
          _getItemTile(
              Icons.menu_book_sharp, 'Tour Ecoparque', 'tour', context),
          _getItemTile(Icons.home_work_outlined, 'AR Ecoparque', 'ar', context),
          _getItemTile(Icons.map, '¡Encuéntranos!', 'map', context),
          Divider(
            color:
                Theme.of(context).appBarTheme.foregroundColor!.withOpacity(0.5),
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).appBarTheme.foregroundColor,
            ),
            title: Text(
              "Cerrar sesión",
              style: TextStyle(
                  color: Theme.of(context).appBarTheme.foregroundColor),
            ),
            onTap: () {
              // Navigator.pop(context);
              loginProvider.logout();
              // Navigator.pop(context);
            },
          ),
          Divider(
              color: Theme.of(context)
                  .appBarTheme
                  .foregroundColor!
                  .withOpacity(0.5)),
          ListTile(
            title: Column(
              children: [
                Image.asset(
                  'assets/logoPrefectura.png',
                  fit: BoxFit.cover,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  SizedBox _getDrawerHeader(context) {
    final usuarioProvider = Provider.of<UserProvider>(context);
    return SizedBox(
      height: 220,
      width: double.infinity,
      child: DrawerHeader(
        child: UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: Colors.transparent),
          currentAccountPicture: ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: CircleAvatar(
              child: Text(usuarioProvider.userGlobal.nombre[0] +
                  "" +
                  usuarioProvider.userGlobal.apellido[0]),
              backgroundColor:
                  Theme.of(context).floatingActionButtonTheme.backgroundColor,
            ),
          ),
          accountName: Text(
            usuarioProvider.userGlobal.nombre +
                ' ' +
                usuarioProvider.userGlobal.apellido,
            style: TextStyle(color: Colors.white),
          ),
          accountEmail: Text(
            usuarioProvider.userGlobal.correo,
            style: TextStyle(color: Colors.white),
          ),
          onDetailsPressed: () {
            // Navigator.pushNamed(context, 'perfil');
          },
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
              colorFilter:
                  ColorFilter.mode(Colors.black45, BlendMode.colorBurn),
              scale: 20.0,
              image: AssetImage('assets/ecoparqueFondo.jpg'),
              fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _getItemTile(
      IconData icon, String text, String ruta, BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).appBarTheme.foregroundColor,
      ),
      title: Text(
        text,
        style: TextStyle(color: Theme.of(context).appBarTheme.foregroundColor),
      ),
      onTap: () {
        Navigator.pushNamed(context, ruta);
      },
    );
  }
}
