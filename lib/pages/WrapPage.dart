import 'package:ecop_app/main.dart';
import 'package:ecop_app/models/UserModel.dart';
import 'package:ecop_app/pages/HomePage.dart';
import 'package:ecop_app/pages/LoginPage.dart';
import 'package:ecop_app/pages/admin/HomeAdminPage.dart';
import 'package:ecop_app/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WrapPage extends StatefulWidget {
  const WrapPage({Key? key}) : super(key: key);

  @override
  State<WrapPage> createState() => _WrapPageState();
}

class _WrapPageState extends State<WrapPage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final usuarioProvider = Provider.of<UserProvider>(context);

    if (user != null) {
      return WillPopScope(
        onWillPop: _onWillPopScope,
        child: FutureBuilder(
          future: usuarioProvider.getUserByIdWithoutNotify(user.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserModel userModel = snapshot.data as UserModel;
              usuarioProvider.setUserGlobalWithoutNotify(userModel);

              if (userModel.rol == "Usuario") {
                return HomePage();
              } else {
                return HomeAdminPage();
              }
            } else if (snapshot.hasError) {
              return ErrorPage();
            } else {
              return CargandoPage();
            }
          },
        ),
      );
    } else {
      return WillPopScope(onWillPop: _onWillPopScope, child: LoginPage());
    }
  }

  Future<bool> _onWillPopScope() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(24, 20, 24, 0),
            title: const Text(
              'Selecione alguna opción',
            ),
            content: Text('¿Estás seguro que quieres salir de la app?'),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('CANCELAR')),
              TextButton(
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  child: Text('SALIR'))
            ],
          );
        }) as Future<bool>;
  }
}
