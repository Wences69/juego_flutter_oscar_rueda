import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../games/OscarGame.dart';

class Gota extends SpriteAnimationComponent
    with HasGameRef<OscarGame> {
  Gota({
    required super.position, super.size
  });
  late ShapeHitbox hitbox;
  final _defaultColor = Colors.red;


  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('water_enemy.png'),
      SpriteAnimationData.sequenced(
        amount: 2,
        amountPerRow: 2,
        textureSize: Vector2.all(16),
        stepTime: 0.12,
      ),
    );

    final defaultPaint = Paint()
      ..color = _defaultColor
      ..style = PaintingStyle.stroke;

    hitbox = RectangleHitbox()
      ..paint = defaultPaint
      ..isSolid=true;
    //..renderShape = true;
    add(hitbox);

    super.onLoad();
  }
}