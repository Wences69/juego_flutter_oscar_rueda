import 'package:flame/components.dart';
import 'package:juego_flutter_oscar_rueda/games/OscarGame.dart';

class EmberPlayer extends SpriteAnimationComponent
    with HasGameRef<OscarGame> {

  EmberPlayer({
    required super.position,
  }) : super(size: Vector2.all(64), anchor: Anchor.center);

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('ember.png'),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(16),
        stepTime: 0.12,
      ),
    );
  }
}