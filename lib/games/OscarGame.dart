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

    // Configura el color de fondo de la cámara
    cameraComponent = CameraComponent(world: world);
    cameraComponent.viewfinder.anchor = Anchor.topLeft;
    addAll([cameraComponent, world]);

    mapComponent = await TiledComponent.load("mapa1.tmx", Vector2.all(32));
    world.add(mapComponent);

    _player = EmberPlayer(
      position: Vector2(128, canvasSize.y - 150),
    );
    world.add(_player);
  }
}
