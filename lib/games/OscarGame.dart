import 'dart:ui';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/services.dart';

import '../bodies/GotaBody.dart';
import '../elementos/Estrella.dart';
import '../players/BarraVida.dart';
import '../players/EmberPlayer.dart';
import '../players/WaterPlayer.dart';

import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_forge2d/forge2d_game.dart';

class OscarGame extends Forge2DGame with
    HasKeyboardHandlerComponents,HasCollisionDetection {
  OscarGame();

  late final CameraComponent cameraComponent;
  late TiledComponent mapComponent;

  double gameWidth = 1920;
  double gameHeigth = 1080;

  double wScale = 1.0;
  double hScale = 1.0;

  late double tamanyo;

  late EmberPlayerBody _player;
  late EmberPlayerBody _player2;
  late WaterPlayer _water;
  late BarraVida barraVida;

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
    // Everything in this tutorial assumes that the position
    // of the `CameraComponent`s viewfinder (where the camera is looking)
    // is in the top left corner, that's why we set the anchor here.
    cameraComponent.viewfinder.anchor = Anchor.topLeft;
    addAll([cameraComponent, world]);

    mapComponent = await TiledComponent.load('mapa1.tmx', Vector2(32*wScale, 32*hScale));
    world.add(mapComponent);

    ObjectGroup? estrellas=mapComponent.tileMap.getLayer<ObjectGroup>("estrellas");

    for(final estrella in estrellas!.objects){
      Estrella spriteStar = Estrella(
          position: Vector2(estrella.x * wScale,estrella.y * hScale),
          size: Vector2(32*wScale, 32*hScale));
      //spriteStar.sprite=Sprite(images.fromCache('star.png'));
      add(spriteStar);
    }

    ObjectGroup? gotas=mapComponent.tileMap.getLayer<ObjectGroup>("gotas");

    for(final gota in gotas!.objects){
      /*Gota spriteGota = Gota(position: Vector2(gota.x * wScale,gota.y * hScale),
          size: Vector2(32*wScale, 32*hScale));
      world.add(spriteGota);*/

      GotaBody gotaBody = GotaBody(posXY: Vector2(gota.x*wScale,gota.y*hScale),
          sizeWH: Vector2(32*wScale,32*hScale));
      //gotaBody.onBeginContact=InicioContactosDelJuego;
      add(gotaBody);
    }

    _player = EmberPlayerBody(
        initialPosition: Vector2(200, canvasSize.y-canvasSize.y/2),
        tamano: Vector2(64*wScale, 64*hScale),
        keyAbajo: LogicalKeyboardKey.keyS,
        keyArriba: LogicalKeyboardKey.keyW,
        keyDerecha: LogicalKeyboardKey.keyD,
        keyIzquierda: LogicalKeyboardKey.keyA
    );
    _player.onBeginContact=InicioContactosDelJuego;
    world.add(_player);

    _water = WaterPlayer(
      position: Vector2(canvasSize.x/2 - 50, canvasSize.y/2 + 50),
    );
    world.add(_water);

    _player2 = EmberPlayerBody(
        initialPosition: Vector2(400, canvasSize.y-canvasSize.y/2),
        tamano: Vector2(64*wScale, 64*hScale),
        keyAbajo: LogicalKeyboardKey.arrowDown,
        keyArriba: LogicalKeyboardKey.arrowUp,
        keyDerecha: LogicalKeyboardKey.arrowRight,
        keyIzquierda: LogicalKeyboardKey.arrowLeft
    );
    _player2.onBeginContact=InicioContactosDelJuegoPlayerDos;
    world.add(_player2);

    barraVida = BarraVida(_player, wScale, hScale);
    world.add(barraVida);
  }

  void InicioContactosDelJuego(Object objeto,Contact contact){
    if(objeto is GotaBody){
      _player.iVidas--;
      if(_player.iVidas==0){
        _player.removeFromParent();
      }
    }
  }

  void InicioContactosDelJuegoPlayerDos(Object objeto,Contact contact){
    if(objeto is GotaBody){
      _player2.iVidas--;
      if(_player2.iVidas==0){
        _player2.removeFromParent();
      }
    }
  }

}