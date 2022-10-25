import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ecop_app/models/UserModel.dart';

class UserProvider with ChangeNotifier {
  CollectionReference usuariosRef =
      FirebaseFirestore.instance.collection(UserModel.collectionId);

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoading(bool lodaing) {
    _isLoading = lodaing;
    notifyListeners();
  }

  UserModel _userGlobal;
  UserModel get userGlobal => _userGlobal;
  UserProvider(this._userGlobal);
  void setUserGlobal(UserModel user) {
    _userGlobal = user;
    notifyListeners();
  }

  void setUserGlobalWithoutNotify(UserModel user) {
    _userGlobal = user;
  }

  Future<void> createUser(UserModel usuario) async {
    setLoading(true);
    await usuariosRef.add(usuario.toMap());
    // print('asdasd');
    // await FirebaseFirestore.instance
    //     .collection('Usuario')
    //     .add({"data": "malkik"});
    setLoading(false);
  }

  Future<UserModel> getUserById(String uid) async {
    setLoading(true);
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
    setLoading(false);
    return usuarioReturn;
  }

  Future<UserModel> getUserByIdWithoutNotify(String uid) async {
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
}
