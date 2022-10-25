import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../providers/AuthProvider.dart';
import '../providers/UserProvider.dart';

class OlvidadoPage extends StatefulWidget {
  const OlvidadoPage({super.key});

  @override
  State<OlvidadoPage> createState() => _OlvidadoPageState();
}

class _OlvidadoPageState extends State<OlvidadoPage> {
  TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Contraseña olvidada')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Text(
                'Ingresa el correo electrónico para poder reestablecer la contraseña. Este procedimiento no esta permitido si tu autenticación fue con Google.'),
            Text(
                'Recuerda revisar en tu correo en la sección denominada Spam o correo electrónico no deseado'),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          value!.isNotEmpty ? null : 'Ingresa el correo',
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
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(),
                    ),
                    MaterialButton(
                      disabledColor: Theme.of(context).primaryColor,
                      onPressed: loginProvider.isLoading
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                await loginProvider.sendPasswordResetEmail(
                                    _emailController.text, context);
                                Navigator.pop(context);
                              }
                            },
                      height: 60,
                      minWidth: double.infinity,
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).appBarTheme.foregroundColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: loginProvider.isLoading
                          ? CircularProgressIndicator(
                              color:
                                  Theme.of(context).appBarTheme.foregroundColor,
                            )
                          : const Text('ENVIAR AL CORREO'),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
