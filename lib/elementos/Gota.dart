import 'package:flame/components.dart';
import '../games/OscarGame.dart';

class Gota extends SpriteAnimationComponent with HasGameRef<OscarGame> {
  Gota({
    required super.position, super.size
  });

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
  }
}