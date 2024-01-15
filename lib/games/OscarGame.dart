import 'package:flame/game.dart';

class OscarGame extends FlameGame {

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      "ember.png",
      "heart.png",
      "heart_half.png",
      "star.png",
      "water_enemy.png"
    ]);
  }
}