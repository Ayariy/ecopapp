import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AyudaPage extends StatefulWidget {
  const AyudaPage({super.key});

  @override
  State<AyudaPage> createState() => AyudaPageState();
}

class AyudaPageState extends State<AyudaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PageView(
          children: [
            MenuPageAyuda(
              listContent: const [
                Text(
                  'Opciones del menú lateral',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: Icon(Icons.menu),
                  title: Text('Menú lateral'),
                  subtitle: Text(
                      'El menú lateral posee diferentes opciones, desde la información del correo electrónico y nombre del perfil.'),
                ),
                ListTile(
                  leading: Icon(Icons.menu_book_sharp),
                  title: Text('Botón Tour Ecoparque'),
                  subtitle: Text(
                      'Este botón nos permite navegar a la visualización del ecoparque en realidad virtual, atravéz de un personaje virtual.'),
                ),
                ListTile(
                  leading: Icon(Icons.home_work_outlined),
                  title: Text('Botón Ar Ecoparque'),
                  subtitle: Text(
                      'Este botón nos permite navegar a la visualización de las esculturas del ecoparque en realidad aumentada, atravéz de la cámara del teléfono.'),
                ),
                ListTile(
                  leading: Icon(Icons.map),
                  title: Text('Botón Map'),
                  subtitle: Text(
                      'Indica la ubicación del ecoparque. Asi como también la capacidad de abrir Google Maps con la ruta hacia la misma.'),
                ),
                ListTile(
                  leading: Icon(Icons.help),
                  title: Text('Botón Ayuda'),
                  subtitle: Text(
                      'Visualiza la página que explicará el funcionamiento de cada uno de los botones.'),
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Botón Cerrar sesión'),
                  subtitle: Text(
                      'Permite cerrar la sesión del usuario registrado o iniciado sesión'),
                ),
                ListTile(
                  leading: Icon(Icons.facebook),
                  title: Text('Botón Facebook'),
                  subtitle: Text(
                      'Ábre la página de facebook de la Prefectura del Carchi'),
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.instagram),
                  title: Text('Botón Facebook'),
                  subtitle: Text(
                      'Ábre la página de instagram de la Prefectura del Carchi'),
                ),
                ListTile(
                  leading: Icon(Icons.star),
                  title: Text('Botón Valoración'),
                  subtitle: Text(
                      'Visualiza la página de valoración, que permite mejorar la experiencia del usuario en relación con la Aplicación, a través de una escala de 0 a 6 estrellas'),
                ),
              ],
            ),
            MenuPageAyuda(
              listContent: [
                Text(
                  'Opciones del menú principal',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const ListTile(
                  title: Text('La navegación inferior posee dos botones:'),
                ),
                SizedBox(
                  height: 20,
                ),
                const ListTile(
                  leading: Icon(Icons.image),
                  title: Text('Página principal'),
                  subtitle: Text(
                      'Permite mostrar la página principal en donde se visualizan las imagenes animadas. Así como tambien escuchar la información de cada uno'),
                ),
                const ListTile(
                  leading: Icon(Icons.info),
                  title: Text('Página secundaria'),
                  subtitle: Text(
                      'Visualiza la página secundaria en donde se encuentra la información de la Prefectura'),
                ),
                const ListTile(
                  leading: Icon(Icons.play_arrow),
                  title: Text('Botón Play'),
                  subtitle: Text(
                      'Reproduce el audio en donde contiene la información de cada item del animal listado en la página principal.'),
                ),
                const ListTile(
                  leading: Icon(Icons.camera),
                  title: Text('Botón Escaneo'),
                  subtitle: Text(
                      'Permite redirigir a la página para escanear los marcadores y poder visualizar las esculturas del ecoparque en realidad Aumentada.'),
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/gifs/rana.gif',
                    fit: BoxFit.cover,
                  ),
                  title: Text('Gif Animado'),
                  subtitle: Text(
                      'Permite redirigir y visualizar el animal en 3d de cada escultura listada en la página principal.'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MenuPageAyuda extends StatelessWidget {
  List<Widget> listContent;
  MenuPageAyuda({required this.listContent});
  @override
  Widget build(BuildContext context) {
    return ListView(children: listContent);
  }
}
