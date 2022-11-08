import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecop_app/models/UserModel.dart';

class AdminProvider {
  CollectionReference usuariosRef =
      FirebaseFirestore.instance.collection(UserModel.collectionId);

  Future<UserModel> getUserById(String uid) async {
    UserModel usuarioReturn = UserModel.userModelNoData();
    QuerySnapshot querySnapshot =
        await usuariosRef.where('UID', isEqualTo: uid).get();
    if (querySnapshot.size > 0) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

      if (documentSnapshot.exists) {
        Map<String, dynamic> mapUser =
            documentSnapshot.data() as Map<String, dynamic>;
        usuarioReturn = UserModel.fromFireStore(mapUser);
      }
    }
    return usuarioReturn;
  }

  Future<List<UserModel>> getUsuarios(DateTime? from) async {
    QuerySnapshot querySnapshot;
    if (from != null) {
      querySnapshot = await usuariosRef
          .orderBy('FechaCreacion', descending: true)
          .startAfter([from])
          .limit(10)
          .get();
    } else {
      querySnapshot = await usuariosRef
          .orderBy('FechaCreacion', descending: true)
          .limit(10)
          .get();
    }

    return querySnapshot.docs.map((elementUser) {
      Map<String, dynamic> userMap = elementUser.data() as Map<String, dynamic>;
      return UserModel.fromFireStore(userMap);
    }).toList();
  }

  Future<List<UserModel>> getAllUsuarios() async {
    QuerySnapshot querySnapshot;

    querySnapshot = await usuariosRef.get();

    return querySnapshot.docs.map((elementUser) {
      Map<String, dynamic> userMap = elementUser.data() as Map<String, dynamic>;
      return UserModel.fromFireStore(userMap);
    }).toList();
  }

  Future<List<UserModel>> getUserByName(String name) async {
    QuerySnapshot querySnapshot = await usuariosRef
        .where('Nombre', isGreaterThanOrEqualTo: name)
        .where('Nombre', isLessThanOrEqualTo: name + "\uf8ff")
        .get();

    return querySnapshot.docs.map((elementUser) {
      Map<String, dynamic> userMap = elementUser.data() as Map<String, dynamic>;
      return UserModel.fromFireStore(userMap);
    }).toList();
  }

  Future<List<UserModel>> getUserByDate(
      DateTime inicio, DateTime fin, String campoBD) async {
    QuerySnapshot querySnapshot = await usuariosRef
        .where(campoBD,
            isGreaterThanOrEqualTo: DateTime(inicio.year, inicio.month,
                inicio.day, inicio.hour, inicio.minute))
        .where(campoBD,
            isLessThanOrEqualTo:
                DateTime(fin.year, fin.month, fin.day, fin.hour, fin.minute))
        .get();
    return querySnapshot.docs.map((elementUser) {
      Map<String, dynamic> userMap = elementUser.data() as Map<String, dynamic>;
      return UserModel.fromFireStore(userMap);
    }).toList();
  }

  Future<List<UserModel>> getUserByPais(String pais) async {
    QuerySnapshot querySnapshot = await usuariosRef
        .where('Pais', isGreaterThanOrEqualTo: pais)
        .where('Pais', isLessThanOrEqualTo: pais + "\uf8ff")
        .get();
    return querySnapshot.docs.map((elementUser) {
      Map<String, dynamic> userMap = elementUser.data() as Map<String, dynamic>;
      return UserModel.fromFireStore(userMap);
    }).toList();
  }

  Future<List<UserModel>> getUserByCiudad(String ciudad) async {
    QuerySnapshot querySnapshot = await usuariosRef
        .where('Ciudad', isGreaterThanOrEqualTo: ciudad)
        .where('Ciudad', isLessThanOrEqualTo: ciudad + "\uf8ff")
        .get();
    return querySnapshot.docs.map((elementUser) {
      Map<String, dynamic> userMap = elementUser.data() as Map<String, dynamic>;
      return UserModel.fromFireStore(userMap);
    }).toList();
  }

  Future<List<UserModel>> getUserByEdad(String edad) async {
    QuerySnapshot querySnapshot = await usuariosRef
        .where('Edad', isGreaterThanOrEqualTo: edad)
        .where('Edad', isLessThanOrEqualTo: edad)
        .get();
    return querySnapshot.docs.map((elementUser) {
      Map<String, dynamic> userMap = elementUser.data() as Map<String, dynamic>;
      return UserModel.fromFireStore(userMap);
    }).toList();
  }

  Future<List<UserModel>> getUserByValoracion(String valoracion) async {
    QuerySnapshot querySnapshot = await usuariosRef
        .where('Valoracion', isGreaterThanOrEqualTo: valoracion)
        .where('Valoracion', isLessThanOrEqualTo: valoracion)
        .get();
    return querySnapshot.docs.map((elementUser) {
      Map<String, dynamic> userMap = elementUser.data() as Map<String, dynamic>;
      return UserModel.fromFireStore(userMap);
    }).toList();
  }

  Future<void> updateUser(UserModel user) async {
    QuerySnapshot querySnapshot =
        await usuariosRef.where('UID', isEqualTo: user.idUsuario).get();
    if (querySnapshot.size > 0) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
      if (documentSnapshot.exists) {
        await usuariosRef.doc(documentSnapshot.id).update(user.toMap());
      }
    }
  }
}
