import 'package:cloud_firestore/cloud_firestore.dart';

class ViewAnimals {
  List<dynamic> caiman;
  List<dynamic> colibri;
  List<dynamic> jaguar;
  List<dynamic> lagartija;
  List<dynamic> murcielago;
  List<dynamic> oso;
  List<dynamic> perezoso;
  List<dynamic> rana;
  List<dynamic> tortuga;
  List<dynamic> venado;

  static const String collectionId = 'ViewAnimals';

  ViewAnimals({
    required this.caiman,
    required this.colibri,
    required this.jaguar,
    required this.lagartija,
    required this.murcielago,
    required this.oso,
    required this.perezoso,
    required this.rana,
    required this.tortuga,
    required this.venado,
  });

  factory ViewAnimals.fromFireStore(Map<String, dynamic> viewAnimals) {
    return ViewAnimals(
      caiman: viewAnimals['caiman'],
      colibri: viewAnimals['colibri'],
      jaguar: viewAnimals['jaguar'],
      lagartija: viewAnimals['lagartija'],
      murcielago: viewAnimals['murcielago'],
      oso: viewAnimals['oso'],
      perezoso: viewAnimals['perezoso'],
      rana: viewAnimals['rana'],
      tortuga: viewAnimals['tortuga'],
      venado: viewAnimals['venado'],
    );
  }

  factory ViewAnimals.userModelNoData() {
    return ViewAnimals(
        caiman: [],
        colibri: [],
        jaguar: [],
        lagartija: [],
        murcielago: [],
        oso: [],
        perezoso: [],
        rana: [],
        tortuga: [],
        venado: []);
  }

  Map<String, dynamic> toMap() => {
        'caiman': caiman,
        'colibri': colibri,
        'jaguar': jaguar,
        'lagartija': lagartija,
        'murcielago': murcielago,
        'oso': oso,
        'perezoso': perezoso,
        'rana': rana,
        'tortuga': tortuga,
        'venado': venado,
      };

  // @override
  // String toString() {
  //   // TODO: implement toString
  //   return 'Usuario {idUsuario:$idUsuario, Nombre:$nombre, Apellido: $apellido, Correo: $correo, FechaCreacion:$fechaCreacion, FechaUltimaVez: $fechaUltimavez, Rol: $rol  }';
  // }
}
