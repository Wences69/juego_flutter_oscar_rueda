import 'dart:ui';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';

import '../elementos/Estrella.dart';
import '../elementos/Gota.dart';
import '../players/EmberPlayer.dart';
import '../players/EmberPlayer2.dart';
import '../players/WaterPlayer.dart';

class OscarGame extends FlameGame with HasKeyboardHandlerComponents {
  OscarGame();

  final world = World();
  late final CameraComponent cameraComponent;
  late TiledComponent mapComponent;

  double gameWidth = 1920;
  double gameHeigth = 1080;

  double wScale = 1.0;
  double hScale = 1.0;

  late EmberPlayer _player;
  late EmberPlayer2 _player2;
  late WaterPlayer _water;

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 173, 223, 255);
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

    mapComponent = await TiledComponent.load('mapa1.tmx', Vector2(32*wScale, 32*hScale));
    world.add(mapComponent);

    ObjectGroup? estrellas = mapComponent.tileMap.getLayer<ObjectGroup>("estrellas");

    if (estrellas != null) {
      for (final estrella in estrellas.objects) {
        Estrella spriteStar = Estrella(
          position: Vector2(estrella.x * wScale, estrella.y * hScale),
          size: Vector2(32 * wScale, 32 * hScale),
        );
        add(spriteStar);
      }
    }

    ObjectGroup? gotas = mapComponent.tileMap.getLayer<ObjectGroup>("gotas");

    if (gotas != null) {
      for (final gota in gotas.objects) {
        Gota spriteGota = Gota(
          position: Vector2(gota.x * wScale, gota.y * hScale),
          size: Vector2(32 * wScale, 32 * hScale),
        );
        world.add(spriteGota);
      }
    }

    _player = EmberPlayer(
      position: Vector2(20, canvasSize.y-100),
    );
    world.add(_player);

    _water = WaterPlayer(
      position: Vector2(canvasSize.x/2 - 50, canvasSize.y/2 + 50),
    );
    world.add(_water);

    _player2 = EmberPlayer2(
      position: Vector2(200, canvasSize.y-100),
    );
    world.add(_player2);
  }
}