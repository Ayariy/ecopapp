import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_cube/flutter_cube.dart';

class TresDObject extends StatefulWidget {
  const TresDObject({super.key});

  @override
  State<TresDObject> createState() => _TresDObjectState();
}

class _TresDObjectState extends State<TresDObject> {
  Object modelo3D = Object(fileName: 'assets/Modelos/oso.obj');
  AudioPlayer player = AudioPlayer();
  PlayerState playerState = PlayerState.stopped;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    player.onPlayerStateChanged.listen((event) {
      if (mounted) {
        setState(() {
          playerState = event;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    String audioName =
        (ModalRoute.of(context)!.settings.arguments as List)[1] as String;
    reproducirAudio(audioName);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    stopAudio();

    player.release();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String modeloString3D =
        (ModalRoute.of(context)!.settings.arguments as List)[0] as String;
    modelo3D = Object(fileName: 'assets/Modelos/${modeloString3D}.obj');
    return Scaffold(
      appBar: AppBar(
        title: Text('Animales 3D'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Cube(
                onSceneCreated: (Scene scene) {
                  scene.world.add(modelo3D);
                  // scene.updateTexture();
                  scene.camera.zoom = 5;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Icon(
              Icons.move_down_rounded,
              size: 30,
              color: Colors.blueAccent.shade700,
            ),
          )
        ],
      ),
    );
  }

  void reproducirAudio(String audioName) async {
    // PlayerState.playing == playerState
    //     ? await player.pause()
    // :
    await player.play(AssetSource('audio/${audioName}'));
  }

  void stopAudio() async {
    if (PlayerState.playing == playerState) {
      await player.stop();
    }
  }
}
