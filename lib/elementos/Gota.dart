import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../games/OscarGame.dart';

class Gota extends SpriteAnimationComponent with HasGameRef<OscarGame> {
  // Hitbox
  late ShapeHitbox hitbox;

  final _defaultColor = Colors.red;

  // Constructor
  Gota({
    required super.position,
    super.size,
  });

  @override
  void onLoad() {
    // Configuración de la animación
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('water_enemy.png'),
      SpriteAnimationData.sequenced(
        amount: 2,
        amountPerRow: 2,
        textureSize: Vector2.all(16),
        stepTime: 0.12,
      ),
    );

    // Configuración de la hitbox
    final defaultPaint = Paint()
      ..color = _defaultColor
      ..style = PaintingStyle.stroke;

    hitbox = RectangleHitbox()
      ..paint = defaultPaint
      ..isSolid = true;

    // Agregar el hitbox a la gota
    add(hitbox);

    super.onLoad();
  }
}
