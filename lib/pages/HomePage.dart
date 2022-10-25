import 'package:audioplayers/audioplayers.dart';
import 'package:ecop_app/models/UserModel.dart';
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
          : Container(
              child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Esculturas del ecoparque',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                          arguments: 'caiman');
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
                          arguments: 'colibri');
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
                          'jaguar', userProvider.userGlobal.idUsuario);
                      if (mounted) {
                        setState(() {
                          isLoading = false;
                        });
                      }
                      Navigator.pushNamed(context, 'modelo3d',
                          arguments: 'jaguar');
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
                          arguments: 'iguana');
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
                                  : await player.play(
                                      AssetSource('audio/lagartija.mpeg'));
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
                          arguments: 'murcielago');
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
                                  : await player.play(
                                      AssetSource('audio/murcielago.mpeg'));
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
                          arguments: 'oso');
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
                          arguments: 'perezoso');
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
                          arguments: 'rana');
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
                          arguments: 'tortuga');
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
                          arguments: 'venado');
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
            )),
      drawer: NavigationDrawer(),
    );
  }

  Future<void> changeUltimavez() async {
    if (mounted) {
      isLoading = true;
      UserProvider userProvider = Provider.of(context, listen: false);
      userProvider.userGlobal.fechaUltimavez = DateTime.now();
      await adminProvider.updateUser(userProvider.userGlobal);
      setState(() {
        isLoading = false;
      });
    }
  }
}
