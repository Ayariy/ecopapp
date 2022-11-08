import 'dart:isolate';

import 'package:ecop_app/models/UserModel.dart';
import 'package:ecop_app/models/ciudades.dart';
import 'package:ecop_app/providers/AdminProvider.dart';
import 'package:ecop_app/providers/UserProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class EncuestaPage extends StatefulWidget {
  const EncuestaPage({super.key});

  @override
  State<EncuestaPage> createState() => _EncuestaPageState();
}

class _EncuestaPageState extends State<EncuestaPage> {
  final _formKey = GlobalKey<FormState>();
  String selectPais = 'Ecuador';
  bool isLoading = false;

  var itemsPais = [
    'Ecuador',
    'Colombia',
    'Otro',
  ];

  String selectCiudad = 'Quito';
  var itemsCiudad = listaCiudades;

  TextEditingController _edadController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        Text('Ayúdanos resolviendo esta encuesta rápidamente:',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'País',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        DropdownButton(
                          isExpanded: true,
                          value: selectPais,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: itemsPais.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectPais = newValue!;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Ciudad',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        DropdownButton(
                          isExpanded: true,
                          value: selectCiudad,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: itemsCiudad.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectCiudad = newValue!;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Edad',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextFormField(
                          enableInteractiveSelection: false,
                          controller: _edadController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value!.isNotEmpty) {
                              if (int.parse(value) >= 0) {
                                return null;
                              } else {
                                return 'El valor debe ser mayor a 0';
                              }
                            } else {
                              return 'Ingresa la edad';
                            }
                          },
                          decoration: const InputDecoration(
                              hintText: 'Agregar la edad',
                              suffixIcon: Icon(Icons.numbers)),
                        ),
                        Divider(),
                        MaterialButton(
                          child: Text('Enviar'),
                          color: Theme.of(context).appBarTheme.backgroundColor,
                          textColor: Colors.white,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              UserProvider userProvider =
                                  Provider.of(context, listen: false);
                              AdminProvider adminProvider = AdminProvider();
                              userProvider.userGlobal.pais = selectPais;
                              userProvider.userGlobal.ciudad = selectCiudad;
                              userProvider.userGlobal.edad =
                                  int.parse(_edadController.text);
                              userProvider.userGlobal.isNew = false;
                              await adminProvider
                                  .updateUser(userProvider.userGlobal);
                              if (mounted) {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                              Navigator.pop(context);
                            }
                          },
                        )
                      ],
                    )),
              ));
  }
}
