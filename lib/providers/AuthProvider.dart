import 'dart:io';
import 'package:ecop_app/models/UserModel.dart';
import 'package:ecop_app/providers/UserProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/widgets.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = "";

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<User?> registerUser(UserModel usuario, String password) async {
    setLoading(true);
    try {
      UserCredential authResult =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: usuario.correo, password: password);
      User userAuth = authResult.user!;
      usuario.idUsuario = userAuth.uid;
      UserProvider userProvider = UserProvider(usuario);
      await userProvider.createUser(usuario);
      setLoading(false);
      return userAuth;
    } on SocketException {
      setLoading(false);
      setMessage('Error, porfavor verifica tu conexión de internet');
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      switch (e.code) {
        case 'email-already-in-use':
          setMessage(
              'Ya existe una cuenta con la dirección de correo electrónico proporcionada.');
          break;
        case 'invalid-email':
          setMessage('La dirección de correo electrónico no es válida.');
          break;
        case 'operation-not-allowed':
          setMessage(
              'Las cuentas de correo electrónico y/o contraseña no están habilitadas.');
          break;
        case 'weak-password':
          setMessage('La contraseña no es lo suficientemente segura.');
          break;
        default:
          setMessage(
              'Ocurrió un error inesperado, vuelva a intentarlo más tarde.');
      }
    } catch (e) {
      setLoading(false);
      setMessage(e.toString());
    }
    notifyListeners();
  }

  Future<User?> loginUser(String email, String password) async {
    setLoading(true);
    try {
      UserCredential authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User userAuth = authResult.user!;
      setLoading(false);
      return userAuth;
    } on SocketException {
      setLoading(false);
      setMessage('Error, porfavor verifica tu conexión de internet');
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      switch (e.code) {
        case 'invalid-email':
          setMessage('El correo electrónico es inválido.');
          break;
        case 'user-disabled':
          setMessage(
              'El usuario correspondiente al correo electrónico dado ha sido deshabilitado.');
          break;
        case 'user-not-found':
          setMessage(
              'No hay un usuario correspondiente al correo electrónico ingresado.');
          break;
        case 'wrong-password':
          setMessage(
              'La contraseña no es válida para el correo electrónico ingresado.');
          break;
        default:
          setMessage(
              'Ocurrió un error inesperado, vuelva a intentarlo más tarde.');
      }
    } catch (e) {
      setLoading(false);
      setMessage(e.toString() + " -");
    }
    notifyListeners();
  }

  Future<User?> logginGoogle() async {
    setLoading(true);
    try {
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        OAuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        UserCredential userCredential =
            await firebaseAuth.signInWithCredential(credential);
        final User? user = userCredential.user;
        setLoading(false);
        return user;
      }
      setLoading(false);
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      switch (e.code) {
        case 'account-exists-with-different-credential':
          setMessage(
              'Ya existe una cuenta con la dirección de correo electrónico.');
          break;
        case 'invalid-credential':
          setMessage(
              'La credencial tiene un formato incorrecto o ha caducado.');
          break;
        case 'operation-not-allowed':
          setMessage(
              'El tipo de cuenta correspondiente a la credencial no está habilitado.');
          break;
        case 'user-disabled':
          setMessage(
              'El usuario correspondiente a la credencial ingresada ha sido deshabilitada.');
          break;
        case 'user-not-found':
          setMessage(
              'No hay ningún usuario que corresponda al correo electrónico ingresado.');
          break;
        case 'wrong-password':
          setMessage(
              'La contraseña no es válida para el correo electrónico proporcionado.');
          break;
        case 'invalid-verification-code':
          setMessage(
              'El código de verificación de la credencial no es válido.');
          break;
        case 'invalid-verification-id':
          setMessage('El ID de verificación de la credencial no es válido.');
          break;
        default:
          setMessage(
              'Ocurrió un error inesperado, vuelva a intentarlo más tarde.');
      }
    } catch (e) {
      setLoading(false);
      setMessage(e.toString() + " -");
    }
    notifyListeners();
  }

  Future logout() async {
    try {
      await firebaseAuth.signOut();
      await googleSignIn.signOut();
    } catch (e) {
      print(e.toString() + '......................................');
    }
    notifyListeners();
  }

  void setLoading(bool lodaing) {
    _isLoading = lodaing;
    notifyListeners();
  }

  void setMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future sendPasswordResetEmail(String email, BuildContext context) async {
    setLoading(true);
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      setLoading(false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          action: SnackBarAction(
            label: "Cerrar",
            onPressed: () {},
          ),
          content: const Text('Revisa tu correo electrónico'),
        ),
      );
    } on FirebaseAuthException catch (e) {
      print(e.toString() + "....................");
      print(e.code + "....................");
      setLoading(false);
      switch (e.code) {
        case 'invalid-email':
          setMessage('Correo electrónico no valido');
          break;
        case 'missing-android-pkg-name':
          setMessage(
              'Se debe proporcionar un nombre de paquete de Android si se requiere instalar la aplicación de Android.');
          break;
        case 'missing-continue-uri':
          setMessage(
              'Se debe proporcionar una URL de continuación en la solicitud.');
          break;
        case 'missing-ios-bundle-id':
          setMessage(
              'Se debe proporcionar una ID de paquete de iOS si se proporciona una ID de App Store.');
          break;
        case 'invalid-continue-uri':
          setMessage(
              'La URL de continuación proporcionada en la solicitud no es válida.');
          break;
        case 'unauthorized-continue-uri':
          setMessage(
              'El dominio de la URL de continuación no está en la lista blanca. Incluya el dominio en la lista blanca en Firebase console.');
          break;
        case 'user-not-found':
          setMessage(
              'No hay un usuario correspondiente a la dirección de correo electrónico.');
          break;
        default:
          setMessage(
              'Ocurrió un error inesperado, vuelva a intentarlo más tarde.');
      }
    } catch (e) {
      setLoading(false);
      setMessage(e.toString() + " -");
    }
    notifyListeners();
  }

  Stream<User?> get user => firebaseAuth.authStateChanges();
}
