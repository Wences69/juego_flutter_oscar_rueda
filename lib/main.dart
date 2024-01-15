import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:juego_flutter_oscar_rueda/games/OscarGame.dart';

void main() {
  final game = OscarGame();
  runApp(GameWidget(game: game));
}

