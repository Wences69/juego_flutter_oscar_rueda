import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'EmberPlayer.dart';

class BarraVida extends PositionComponent {
  final EmberPlayerBody jugador;

  BarraVida(this.jugador);

  @override
  void render(Canvas c) {
    final barraVidaWidth = 600.0;
    final barraVidaHeight = 60.0;
    final vidaActualWidth = (jugador.iVidas / 3) * barraVidaWidth; // Considerando que iVidas va de 0 a 3

    // Dibujar el contorno de la barra de vida
    c.drawRect(
      Rect.fromPoints(
        Offset(60, 80), // Añadir margen izquierdo y superior
        Offset(60 + barraVidaWidth, 80 + barraVidaHeight), // Añadir margen izquierdo y superior
      ),
      Paint()..color = Colors.black,
    );

    // Dibujar la barra de vida actual
    c.drawRect(
      Rect.fromPoints(
        Offset(60, 80), // Añadir margen izquierdo y superior
        Offset(60 + vidaActualWidth, 80 + barraVidaHeight), // Añadir margen izquierdo y superior
      ),
      Paint()..color = Colors.green,
    );

    // Dibujar el texto encima de la barra de vida
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'Vidas del jugador: ${jugador.iVidas}',
        style: TextStyle(color: Colors.black, fontSize: 48),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(c, Offset(135, 15)); // Ajustar posición según el diseño
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Mantener la posición de la barra de vida estática en la esquina superior izquierda con margen
    this.x = 0;
    this.y = 0;
  }
}