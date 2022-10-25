import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecop_app/models/ViewAnimals.dart';
import 'package:flutter/material.dart';

class ViewAnimalsProvider {
  CollectionReference viewAnimalsRef =
      FirebaseFirestore.instance.collection(ViewAnimals.collectionId);
  String idDocAnimals = 'xghqepvAWUilmPJ4AYY4';

  addViewUser(String animal, String idUser) async {
    await viewAnimalsRef.doc(idDocAnimals).update({
      animal: FieldValue.arrayUnion([idUser])
    });
  }

  removeViewUser(String animal, String idUser) async {
    await viewAnimalsRef.doc(idDocAnimals).update({
      animal: FieldValue.arrayRemove([idUser])
    });
  }

  Future<bool> isViewUser(String animal, String idUser) async {
    DocumentSnapshot documentSnapshotView =
        await viewAnimalsRef.doc(idDocAnimals).get();
    Map<String, dynamic> mapView =
        documentSnapshotView.data() as Map<String, dynamic>;
    List<String> listUserAnimals = List.from(mapView[animal]);

    bool isFavorite = listUserAnimals.contains(idUser);

    return isFavorite;
  }

  Future<ViewAnimals> getViewsAnimals() async {
    ViewAnimals viewAnimals = new ViewAnimals.userModelNoData();
    DocumentSnapshot documentSnapshotView =
        await viewAnimalsRef.doc(idDocAnimals).get();
    Map<String, dynamic> mapView =
        documentSnapshotView.data() as Map<String, dynamic>;
    viewAnimals = ViewAnimals.fromFireStore(mapView);
    return viewAnimals;
  }
}
