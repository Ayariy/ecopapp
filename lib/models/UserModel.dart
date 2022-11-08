import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String idUsuario;
  String nombre;
  String apellido;
  String correo;
  DateTime fechaCreacion;
  DateTime fechaUltimavez;
  String rol;
  String pais;
  String ciudad;
  int edad;
  bool isNew;
  double valoracion;

  static const String collectionId = 'Usuario';

  UserModel({
    required this.idUsuario,
    required this.nombre,
    required this.apellido,
    required this.correo,
    required this.fechaCreacion,
    required this.fechaUltimavez,
    required this.rol,
    required this.pais,
    required this.ciudad,
    required this.edad,
    required this.isNew,
    required this.valoracion,
  });

  factory UserModel.fromFireStore(Map<String, dynamic> usuario) {
    return UserModel(
      idUsuario: usuario['UID'],
      nombre: usuario['Nombre'],
      apellido: usuario['Apellido'],
      correo: usuario['Correo'],
      fechaCreacion: usuario['FechaCreacion'].toDate(),
      fechaUltimavez: usuario['FechaUltimavez'].toDate(),
      rol: usuario['Rol'],
      pais: usuario['Pais'],
      ciudad: usuario['Ciudad'],
      edad: usuario['Edad'],
      isNew: usuario['IsNew'],
      valoracion: usuario['Valoracion'].toDouble(),
    );
  }

  factory UserModel.userModelNoData() {
    return UserModel(
      idUsuario: '',
      nombre: '',
      apellido: '',
      correo: '',
      fechaCreacion: DateTime.now(),
      fechaUltimavez: DateTime.now(),
      rol: '',
      pais: '',
      ciudad: '',
      edad: 0,
      isNew: false,
      valoracion: 0,
    );
  }

  Map<String, dynamic> toMap() => {
        'UID': idUsuario,
        'Nombre': nombre,
        'Apellido': apellido,
        'Correo': correo,
        'FechaCreacion': fechaCreacion,
        'FechaUltimavez': fechaUltimavez,
        'Rol': rol,
        'Pais': pais,
        'Ciudad': ciudad,
        'Edad': edad,
        'IsNew': isNew,
        'Valoracion': valoracion,
      };

  @override
  String toString() {
    // TODO: implement toString
    return 'Usuario {idUsuario:$idUsuario, Nombre:$nombre, Apellido: $apellido, Correo: $correo, FechaCreacion:$fechaCreacion, FechaUltimaVez: $fechaUltimavez, Rol: $rol  }';
  }
}
