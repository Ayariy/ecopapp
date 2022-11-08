import 'package:ecop_app/models/UserModel.dart';
import 'package:ecop_app/providers/AdminProvider.dart';
import 'package:ecop_app/providers/UserProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ValoracionPage extends StatefulWidget {
  const ValoracionPage({super.key});

  @override
  State<ValoracionPage> createState() => _ValoracionPageState();
}

class _ValoracionPageState extends State<ValoracionPage> {
  bool isLoading = false;
  AdminProvider admin = AdminProvider();
  double rating = 0;
  UserModel userModel = UserModel.userModelNoData();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      _getValoracion();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('¡Ayudanos a mejorar!')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  const FadeInImage(
                      width: 300,
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/logoPrefectura.png'),
                      image: AssetImage('assets/logoPrefectura.png')),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('¡Ayúdanos a mejorar con tu valoración!',
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: RatingBar.builder(
                      initialRating: rating,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 6,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        userModel.valoracion = rating;
                        admin.updateUser(userModel);
                      },
                    ),
                  ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                ],
              ),
      ),
    );
  }

  void _getValoracion() {
    isLoading = true;
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userModel = userProvider.userGlobal;
    rating = userModel.valoracion;
    setState(() {
      isLoading = false;
    });
  }
}
