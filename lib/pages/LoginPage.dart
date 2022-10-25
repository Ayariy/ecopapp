import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/UserModel.dart';
import '../providers/AuthProvider.dart';
import '../providers/UserProvider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final loginProvider = Provider.of<AuthProvider>(context);
    final usuarioProvider = Provider.of<UserProvider>(context);

    return Scaffold(
        body: Stack(children: [
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6), BlendMode.dstATop),
                fit: BoxFit.cover,
                image: const AssetImage('assets/ecoparqueFondo.jpg'))),
        width: double.infinity,
        height: double.infinity,
      ),
      ListView(
        children: [
          Image.asset(
            'assets/logoPrefectura.png',
            fit: BoxFit.cover,
            width: size.height * 0.18,
            height: size.height * 0.18,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          value!.isNotEmpty ? null : 'Ingresa tu correo',
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.email),
                          hintText: 'Correo',
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      validator: (value) =>
                          value!.isNotEmpty ? null : 'Ingresa tu contraseña',
                      obscureText: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.password),
                          hintText: 'Contraseña',
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    const SizedBox(height: 20),
                    if (loginProvider.errorMessage != "")
                      Container(
                        margin: const EdgeInsets.only(bottom: 25),
                        // padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        color: Theme.of(context).errorColor,
                        child: ListTile(
                          textColor: Colors.white,
                          title: Text(loginProvider.errorMessage),
                          iconColor: Colors.white,
                          leading: const Icon(Icons.error),
                          trailing: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              loginProvider.setMessage("");
                            },
                          ),
                        ),
                      ),
                    MaterialButton(
                      disabledColor: Theme.of(context).primaryColor,
                      onPressed:
                          loginProvider.isLoading || usuarioProvider.isLoading
                              ? null
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    User? user = await loginProvider.loginUser(
                                        _emailController.text,
                                        _passwordController.text);

                                    if (user != null) {
                                      // Navigator.pushNamed(context, "home");
                                    }
                                  }
                                },
                      height: 60,
                      minWidth: double.infinity,
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).appBarTheme.foregroundColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: loginProvider.isLoading ||
                              usuarioProvider.isLoading
                          ? CircularProgressIndicator(
                              color:
                                  Theme.of(context).appBarTheme.foregroundColor,
                            )
                          : const Text('INICIAR SESIÓN'),
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor:
                              const Color.fromARGB(255, 17, 97, 162),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "olvidado");
                        },
                        child: const Text('¿Olvidaste tu contraseña?')),
                    const Divider(),
                    MaterialButton(
                      disabledColor: Colors.red.shade900,
                      onPressed: loginProvider.isLoading ||
                              usuarioProvider.isLoading
                          ? null
                          : () async {
                              User? user = await loginProvider.logginGoogle();
                              if (user != null) {
                                final UserModel userLoggin =
                                    await usuarioProvider.getUserById(user.uid);
                                if (userLoggin.idUsuario == '') {
                                  String userName =
                                      user.displayName ?? 'Nombre desconocido';
                                  UserModel userModel = UserModel(
                                      idUsuario: user.uid,
                                      nombre: userName.split(' ').first,
                                      apellido: userName.split(' ').last,
                                      correo: user.email ?? 'Email desconocido',
                                      fechaCreacion: DateTime.now(),
                                      fechaUltimavez: DateTime.now(),
                                      rol: "Usuario");

                                  await usuarioProvider.createUser(userModel);
                                  // usuarioProvider.setUserGlobal(userModel);
                                  // Navigator.of(context).pop();

                                } else {
                                  // Navigator.of(context).pop();
                                }
                              }
                            },
                      height: 60,
                      minWidth: double.infinity,
                      color: Colors.red.shade900,
                      textColor: Theme.of(context).appBarTheme.foregroundColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: ListTileTheme(
                        iconColor:
                            Theme.of(context).appBarTheme.foregroundColor,
                        textColor:
                            Theme.of(context).appBarTheme.foregroundColor,
                        child:
                            loginProvider.isLoading || usuarioProvider.isLoading
                                ? CircularProgressIndicator(
                                    color: Theme.of(context)
                                        .appBarTheme
                                        .foregroundColor,
                                  )
                                : const ListTile(
                                    leading: Icon(FontAwesomeIcons.google),
                                    title: Text('INICIAR SESIÓN CON GOOGLE'),
                                  ),
                      ),
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                          primary: Color.fromARGB(255, 17, 97, 162),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "registro");
                        },
                        child: Text('¿No tienes una cuenta?, Registrate')),
                  ],
                )),
          )
        ],
      )
    ]));
  }
}
