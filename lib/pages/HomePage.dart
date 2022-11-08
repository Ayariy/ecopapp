import 'package:audioplayers/audioplayers.dart';
import 'package:ecop_app/models/UserModel.dart';
import 'package:ecop_app/pages/EncuestaPage.dart';
import 'package:ecop_app/providers/ViewAnimalsProvider.dart';
import 'package:ecop_app/utils/NavigationDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/AdminProvider.dart';
import '../providers/UserProvider.dart';

import 'package:flutter_cube/flutter_cube.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AdminProvider adminProvider = AdminProvider();
  bool isLoading = false;
  ViewAnimalsProvider viewAnimalsProvider = new ViewAnimalsProvider();
  Object rana = Object(fileName: 'assets/Modelos/oso.obj');
  AudioPlayer player = AudioPlayer();
  PlayerState playerState = PlayerState.stopped;

  UserModel userModel = UserModel.userModelNoData();

  int paginaActual = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changeUltimavez();
    player.onPlayerStateChanged.listen((event) {
      setState(() {
        playerState = event;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    player.release();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    UserProvider userProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Prefectura'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : getPage(),
      drawer: NavigationDrawer(),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              paginaActual = value;
            });
          },
          currentIndex: paginaActual,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.image_sharp), label: '3D'),
            BottomNavigationBarItem(
                icon: Icon(Icons.info_outlined), label: 'PC'),
          ]),
    );
  }

  Widget getPage() {
    final size = MediaQuery.of(context).size;
    UserProvider userProvider = Provider.of(context);
    switch (paginaActual) {
      case 0:
        return Container(
            child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Esculturas del ecoparque',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ListTile(
              title: GestureDetector(
                onTap: (() async {
                  if (mounted) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                  await viewAnimalsProvider.addViewUser(
                      'caiman', userProvider.userGlobal.idUsuario);
                  if (mounted) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                  Navigator.pushNamed(context, 'modelo3d',
                      arguments: ['caiman', 'caiman.mpeg']);
                }),
                child: Image.asset(
                  'assets/gifs/caiman.gif',
                  fit: BoxFit.cover,
                ),
              ),
              leading: Column(
                children: [
                  Expanded(
                    child: IconButton(
                        onPressed: () async {
                          PlayerState.playing == playerState
                              ? await player.pause()
                              : await player
                                  .play(AssetSource('audio/caiman.mpeg'));
                        },
                        icon: (PlayerState.playing == playerState)
                            ? Icon(Icons.pause_rounded)
                            : Icon(Icons.play_arrow_rounded)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          print('asd');
                          Navigator.pushNamed(context, 'ar');
                        },
                        icon: Icon(Icons.camera_outlined)),
                  )
                ],
              ),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              title: GestureDetector(
                onTap: (() async {
                  if (mounted) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                  await viewAnimalsProvider.addViewUser(
                      'colibri', userProvider.userGlobal.idUsuario);
                  if (mounted) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                  Navigator.pushNamed(context, 'modelo3d',
                      arguments: ['colibri', 'colibri.mpeg']);
                }),
                child: Image.asset(
                  'assets/gifs/colibri.gif',
                  fit: BoxFit.cover,
                ),
              ),
              leading: Column(
                children: [
                  Expanded(
                    child: IconButton(
                        onPressed: () async {
                          PlayerState.playing == playerState
                              ? await player.pause()
                              : await player
                                  .play(AssetSource('audio/colibri.mpeg'));
                        },
                        icon: (PlayerState.playing == playerState)
                            ? Icon(Icons.pause_rounded)
                            : Icon(Icons.play_arrow_rounded)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'ar');
                        },
                        icon: Icon(Icons.camera_outlined)),
                  )
                ],
              ),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              title: GestureDetector(
                onTap: (() async {
                  if (mounted) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                  await viewAnimalsProvider.addViewUser(
                      'jaguar', userProvider.userGlobal.idUsuario);
                  if (mounted) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                  Navigator.pushNamed(context, 'modelo3d',
                      arguments: ['jaguar', 'puma.mpeg']);
                }),
                child: Image.asset(
                  'assets/gifs/jaguar.gif',
                  fit: BoxFit.cover,
                ),
              ),
              leading: Column(
                children: [
                  Expanded(
                    child: IconButton(
                        onPressed: () async {
                          PlayerState.playing == playerState
                              ? await player.pause()
                              : await player
                                  .play(AssetSource('audio/puma.mpeg'));
                        },
                        icon: (PlayerState.playing == playerState)
                            ? Icon(Icons.pause_rounded)
                            : Icon(Icons.play_arrow_rounded)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          print('asd');
                          Navigator.pushNamed(context, 'ar');
                        },
                        icon: Icon(Icons.camera_outlined)),
                  )
                ],
              ),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              title: GestureDetector(
                onTap: (() async {
                  if (mounted) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                  await viewAnimalsProvider.addViewUser(
                      'lagartija', userProvider.userGlobal.idUsuario);
                  if (mounted) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                  Navigator.pushNamed(context, 'modelo3d',
                      arguments: ['iguana', 'lagartija.mpeg']);
                }),
                child: Image.asset(
                  'assets/gifs/lagartija.gif',
                  fit: BoxFit.cover,
                ),
              ),
              leading: Column(
                children: [
                  Expanded(
                    child: IconButton(
                        onPressed: () async {
                          PlayerState.playing == playerState
                              ? await player.pause()
                              : await player
                                  .play(AssetSource('audio/lagartija.mpeg'));
                        },
                        icon: (PlayerState.playing == playerState)
                            ? Icon(Icons.pause_rounded)
                            : Icon(Icons.play_arrow_rounded)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          print('asd');
                          Navigator.pushNamed(context, 'ar');
                        },
                        icon: Icon(Icons.camera_outlined)),
                  )
                ],
              ),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              title: GestureDetector(
                onTap: () async {
                  if (mounted) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                  await viewAnimalsProvider.addViewUser(
                      'murcielago', userProvider.userGlobal.idUsuario);
                  if (mounted) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                  Navigator.pushNamed(context, 'modelo3d',
                      arguments: ['murcielago', 'murcielago.mpeg']);
                },
                child: Image.asset(
                  'assets/gifs/murcielago.gif',
                  fit: BoxFit.cover,
                ),
              ),
              leading: Column(
                children: [
                  Expanded(
                    child: IconButton(
                        onPressed: () async {
                          PlayerState.playing == playerState
                              ? await player.pause()
                              : await player
                                  .play(AssetSource('audio/murcielago.mpeg'));
                        },
                        icon: (PlayerState.playing == playerState)
                            ? Icon(Icons.pause_rounded)
                            : Icon(Icons.play_arrow_rounded)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          print('asd');
                          Navigator.pushNamed(context, 'ar');
                        },
                        icon: Icon(Icons.camera_outlined)),
                  )
                ],
              ),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              title: GestureDetector(
                onTap: () async {
                  if (mounted) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                  await viewAnimalsProvider.addViewUser(
                      'oso', userProvider.userGlobal.idUsuario);
                  if (mounted) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                  Navigator.pushNamed(context, 'modelo3d',
                      arguments: ['oso', 'oso.mpeg']);
                },
                child: Image.asset(
                  'assets/gifs/oso.gif',
                  fit: BoxFit.cover,
                ),
              ),
              leading: Column(
                children: [
                  Expanded(
                    child: IconButton(
                        onPressed: () async {
                          PlayerState.playing == playerState
                              ? await player.pause()
                              : await player
                                  .play(AssetSource('audio/oso.mpeg'));
                        },
                        icon: (PlayerState.playing == playerState)
                            ? Icon(Icons.pause_rounded)
                            : Icon(Icons.play_arrow_rounded)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          print('asd');
                          Navigator.pushNamed(context, 'ar');
                        },
                        icon: Icon(Icons.camera_outlined)),
                  )
                ],
              ),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              title: GestureDetector(
                onTap: () async {
                  if (mounted) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                  await viewAnimalsProvider.addViewUser(
                      'perezoso', userProvider.userGlobal.idUsuario);
                  if (mounted) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                  Navigator.pushNamed(context, 'modelo3d',
                      arguments: ['perezoso', 'perezoso.mpeg']);
                },
                child: Image.asset(
                  'assets/gifs/perezoso.gif',
                  fit: BoxFit.cover,
                ),
              ),
              leading: Column(
                children: [
                  Expanded(
                    child: IconButton(
                        onPressed: () async {
                          PlayerState.playing == playerState
                              ? await player.pause()
                              : await player
                                  .play(AssetSource('audio/perezoso.mpeg'));
                        },
                        icon: (PlayerState.playing == playerState)
                            ? Icon(Icons.pause_rounded)
                            : Icon(Icons.play_arrow_rounded)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          print('asd');
                          Navigator.pushNamed(context, 'ar');
                        },
                        icon: Icon(Icons.camera_outlined)),
                  )
                ],
              ),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              title: GestureDetector(
                onTap: () async {
                  if (mounted) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                  await viewAnimalsProvider.addViewUser(
                      'rana', userProvider.userGlobal.idUsuario);
                  if (mounted) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                  Navigator.pushNamed(context, 'modelo3d',
                      arguments: ['rana', 'rana.mpeg']);
                },
                child: Image.asset(
                  'assets/gifs/rana.gif',
                  fit: BoxFit.cover,
                ),
              ),
              leading: Column(
                children: [
                  Expanded(
                    child: IconButton(
                        onPressed: () async {
                          PlayerState.playing == playerState
                              ? await player.pause()
                              : await player
                                  .play(AssetSource('audio/rana.mpeg'));
                        },
                        icon: (PlayerState.playing == playerState)
                            ? Icon(Icons.pause_rounded)
                            : Icon(Icons.play_arrow_rounded)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          print('asd');
                          Navigator.pushNamed(context, 'ar');
                        },
                        icon: Icon(Icons.camera_outlined)),
                  )
                ],
              ),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              title: GestureDetector(
                onTap: () async {
                  if (mounted) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                  await viewAnimalsProvider.addViewUser(
                      'tortuga', userProvider.userGlobal.idUsuario);
                  if (mounted) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                  Navigator.pushNamed(context, 'modelo3d',
                      arguments: ['tortuga', 'tortuga.mpeg']);
                },
                child: Image.asset(
                  'assets/gifs/tortuga.gif',
                  fit: BoxFit.cover,
                ),
              ),
              leading: Column(
                children: [
                  Expanded(
                    child: IconButton(
                        onPressed: () async {
                          PlayerState.playing == playerState
                              ? await player.pause()
                              : await player
                                  .play(AssetSource('audio/tortuga.mpeg'));
                        },
                        icon: (PlayerState.playing == playerState)
                            ? Icon(Icons.pause_rounded)
                            : Icon(Icons.play_arrow_rounded)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          print('asd');
                          Navigator.pushNamed(context, 'ar');
                        },
                        icon: Icon(Icons.camera_outlined)),
                  )
                ],
              ),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              title: GestureDetector(
                onTap: () async {
                  if (mounted) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                  await viewAnimalsProvider.addViewUser(
                      'venado', userProvider.userGlobal.idUsuario);
                  if (mounted) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                  Navigator.pushNamed(context, 'modelo3d',
                      arguments: ['venado', 'venado.mpeg']);
                },
                child: Image.asset(
                  'assets/gifs/venado.gif',
                  fit: BoxFit.cover,
                ),
              ),
              leading: Column(
                children: [
                  Expanded(
                    child: IconButton(
                        onPressed: () async {
                          PlayerState.playing == playerState
                              ? await player.pause()
                              : await player
                                  .play(AssetSource('audio/venado.mpeg'));
                        },
                        icon: (PlayerState.playing == playerState)
                            ? Icon(Icons.pause_rounded)
                            : Icon(Icons.play_arrow_rounded)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          print('asd');
                          Navigator.pushNamed(context, 'ar');
                        },
                        icon: Icon(Icons.camera_outlined)),
                  )
                ],
              ),
              onTap: () {},
            )
          ],
        ));
      case 1:
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
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
                    'En el Carchi empieza y termina la Patria Ecuatoriana, puerta de entrada para el Turismo y el Comercio')
              ],
            ),
          ),
        );
      default:
        return Container();
    }
  }

  Future<void> changeUltimavez() async {
    if (mounted) {
      isLoading = true;
      UserProvider userProvider = Provider.of(context, listen: false);
      userProvider.userGlobal.fechaUltimavez = DateTime.now();
      userModel = userProvider.userGlobal;
      await adminProvider.updateUser(userProvider.userGlobal);
      setState(() {
        isLoading = false;
      });
      if (userModel.isNew) {
        Navigator.pushNamed(context, 'encuesta');
      }
    }
  }
}
