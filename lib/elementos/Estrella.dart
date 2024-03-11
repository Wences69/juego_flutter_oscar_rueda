import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../games/OscarGame.dart';

class Estrella extends SpriteComponent with HasGameRef<OscarGame>, CollisionCallbacks {
  // Hitbox
  late ShapeHitbox hitbox;

  // Constructor
  Estrella({
    required super.position,
    required super.size
  });

  @override
  Future<void> onLoad() async {
    sprite = Sprite(game.images.fromCache('star.png'));

    // Establecer el punto de anclaje en el centro de la estrella
    anchor = Anchor.center;

    // Configuración de la hitbox
    final transparentPaint = Paint()
      ..color = Colors.transparent // Cambia a color transparente
      ..style = PaintingStyle.stroke;

    hitbox = RectangleHitbox()
      ..paint = transparentPaint
      ..isSolid = true
      ..renderShape = true;

    // Agregar el hitbox a la estrella
    add(hitbox);

    return super.onLoad();
  }
}
