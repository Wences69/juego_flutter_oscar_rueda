import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:juego_flutter_oscar_rueda/games/OscarGame.dart';

void main() {
  runApp(
    const GameWidget<OscarGame>.controlled(gameFactory: OscarGame.new)
  );
}

