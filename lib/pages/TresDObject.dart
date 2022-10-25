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
  @override
  Widget build(BuildContext context) {
    String modeloString3D =
        ModalRoute.of(context)!.settings.arguments as String;
    modelo3D = Object(fileName: 'assets/Modelos/${modeloString3D}.obj');
    return Scaffold(
      appBar: AppBar(
        title: Text('Animales 3D'),
      ),
      body: Container(
        child: Cube(
          onSceneCreated: (Scene scene) {
            scene.world.add(modelo3D);
            // scene.updateTexture();
            scene.camera.zoom = 5;
          },
        ),
      ),
    );
  }
}
