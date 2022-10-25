import 'package:ecop_app/pages/HomePage.dart';
import 'package:ecop_app/providers/AuthProvider.dart';
import 'package:ecop_app/providers/UserProvider.dart';
import 'package:ecop_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'models/UserModel.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _initApp = Firebase.initializeApp();
    return FutureBuilder(
        future: _initApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const ErrorPage();
          } else if (snapshot.hasData) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<AuthProvider>.value(
                    value: AuthProvider()),
                StreamProvider.value(
                    value: AuthProvider().user, initialData: null),
                ChangeNotifierProvider(
                    create: (_) => UserProvider(UserModel.userModelNoData())),
              ],
              child: const EcopApp(),
            );
          } else {
            return CargandoPage();
          }
        });
  }
}

class EcopApp extends StatelessWidget {
  const EcopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', 'US'), // English, no country code
        Locale('es', 'ES'),
      ],
      title: "Ecoparque App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color.fromARGB(255, 5, 80, 41),
          appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(255, 5, 80, 41),
              foregroundColor: Colors.white),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Color.fromARGB(255, 242, 101, 34)),
          errorColor: Color.fromARGB(255, 177, 17, 22)),

      routes: getAplicationRoutes(),
      // home: WrapPage(),
      initialRoute: 'wrap',
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          return const HomePage();
        });
      },
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              FadeInImage(
                  width: 300,
                  fit: BoxFit.cover,
                  placeholder: AssetImage('assets/logoPrefectura.png'),
                  image: AssetImage('assets/logoPrefectura.png')),
              SizedBox(
                height: 20,
              ),
              Text(
                  'Lo sentimos, ocurrió un error inesperado, vuelve a intentarlo más tarde')
            ],
          ),
        ),
      ),
    );
  }
}

class CargandoPage extends StatelessWidget {
  const CargandoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              FadeInImage(
                  width: 300,
                  fit: BoxFit.cover,
                  placeholder: AssetImage('assets/logoPrefectura.png'),
                  image: AssetImage('assets/logoPrefectura.png')),
              SizedBox(
                height: 20,
              ),
              CircularProgressIndicator(),
              SizedBox(
                height: 20,
              ),
              Text('Cargando...')
            ],
          ),
        ),
      ),
    );
  }
}
