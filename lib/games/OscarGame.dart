import 'dart:ui';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';

import '../players/EmberPlayer.dart';

class OscarGame extends FlameGame {
  final world = World();
  late final CameraComponent cameraComponent;
  late EmberPlayer _player;
  late TiledComponent mapComponent;

  double gameWidth = 1920;
  double gameHeigth = 1080;

  double wScale = 1.0;
  double hScale = 1.0;

  @override
  Color backgroundColor() {
    return Color.fromRGBO(102, 178, 255, 1.0);
  }

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'ember.png',
      'heart_half.png',
      'heart.png',
      'star.png',
      'water_enemy.png',
      'tilemap1_32.png'
    ]);

    wScale = size.x/gameWidth;
    hScale = size.y/gameHeigth;


    cameraComponent = CameraComponent(world: world);
    cameraComponent.viewfinder.anchor = Anchor.topLeft;
    addAll([cameraComponent, world]);

    mapComponent = await TiledComponent.load("mapa1.tmx", Vector2(32*wScale, 32*hScale));
    world.add(mapComponent);

    _player = EmberPlayer(
      position: Vector2(128, canvasSize.y - 150),
    );
    world.add(_player);
  }
}
