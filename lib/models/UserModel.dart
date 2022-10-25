import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String idUsuario;
  String nombre;
  String apellido;
  String correo;
  DateTime fechaCreacion;
  DateTime fechaUltimavez;
  String rol;

  static const String collectionId = 'Usuario';

  UserModel(
      {required this.idUsuario,
      required this.nombre,
      required this.apellido,
      required this.correo,
      required this.fechaCreacion,
      required this.fechaUltimavez,
      required this.rol});

  factory UserModel.fromFireStore(Map<String, dynamic> usuario) {
    return UserModel(
      idUsuario: usuario['UID'],
      nombre: usuario['Nombre'],
      apellido: usuario['Apellido'],
      correo: usuario['Correo'],
      fechaCreacion: usuario['FechaCreacion'].toDate(),
      fechaUltimavez: usuario['FechaUltimavez'].toDate(),
      rol: usuario['Rol'],
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
        rol: '');
  }

  Map<String, dynamic> toMap() => {
        'UID': idUsuario,
        'Nombre': nombre,
        'Apellido': apellido,
        'Correo': correo,
        'FechaCreacion': fechaCreacion,
        'FechaUltimavez': fechaUltimavez,
        'Rol': rol,
      };

  @override
  String toString() {
    // TODO: implement toString
    return 'Usuario {idUsuario:$idUsuario, Nombre:$nombre, Apellido: $apellido, Correo: $correo, FechaCreacion:$fechaCreacion, FechaUltimaVez: $fechaUltimavez, Rol: $rol  }';
  }
}
