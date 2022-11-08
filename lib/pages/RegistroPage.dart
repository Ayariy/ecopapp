import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/UserModel.dart';
import '../providers/AuthProvider.dart';
import '../providers/UserProvider.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({Key? key}) : super(key: key);

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  TextEditingController _apellidoController = TextEditingController();
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _correoController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _apellidoController.dispose();
    _nombreController.dispose();
    _correoController.dispose();
    _passwordController.dispose();

    TextEditingController _fechaCreacionController = TextEditingController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthProvider>(context);
    final usuarioProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Registrarse')),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¡Bienvenido a Ecop APP!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Llena los siguientes campos para crear una cuenta',
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: _nombreController,
                  validator: (value) =>
                      value!.isNotEmpty ? null : 'Ingresa tu nombre',
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.badge),
                      hintText: 'Nombre',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _apellidoController,
                  validator: (value) =>
                      value!.isNotEmpty ? null : 'Ingresa tu apellido',
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.assignment),
                      hintText: 'Apellido',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _correoController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingresa tu correo';
                    } else if (value.contains('@') &&
                        value.contains('.') &&
                        value.endsWith('.com')) {
                      return null;
                    } else {
                      return 'Ingresa correctamente tu correo';
                    }
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Correo',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    String pattern =
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~_.-;:]).{8,}$';
                    RegExp regex = new RegExp(pattern);
                    if (value!.length >= 6) {
                      if (!regex.hasMatch(value))
                        return 'Ingresa una contraseña válida.';
                      else
                        return null;
                    } else {
                      return 'Tu contraseña debe ser mayor a 6 dígitos';
                    }
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key),
                      hintText: 'Contraseña',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 15,
                ),
                MaterialButton(
                    disabledColor: Theme.of(context).primaryColor,
                    onPressed:
                        loginProvider.isLoading || usuarioProvider.isLoading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  UserModel userModel = UserModel(
                                      idUsuario: '',
                                      nombre: _nombreController.text,
                                      apellido: _apellidoController.text,
                                      correo: _correoController.text,
                                      fechaCreacion: DateTime.now(),
                                      fechaUltimavez: DateTime.now(),
                                      rol: "Usuario",
                                      pais: '',
                                      ciudad: '',
                                      edad: 0,
                                      isNew: true,
                                      valoracion: 0);
                                  User? user = await loginProvider.registerUser(
                                      userModel, _passwordController.text);
                                  if (user != null) {
                                    Navigator.pop(context);
                                  }
                                }
                              },
                    height: 60,
                    minWidth: double.infinity,
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).appBarTheme.foregroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: loginProvider.isLoading || usuarioProvider.isLoading
                        ? CircularProgressIndicator(
                            color:
                                Theme.of(context).appBarTheme.foregroundColor,
                          )
                        : Text('CREAR CUENTA')),
                if (loginProvider.errorMessage != "")
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    // padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    color: Colors.amberAccent,
                    child: ListTile(
                      title: Text(loginProvider.errorMessage),
                      leading: Icon(Icons.error),
                      trailing: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          loginProvider.setMessage("");
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
