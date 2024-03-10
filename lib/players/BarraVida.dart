import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'EmberPlayer.dart';

class BarraVida extends PositionComponent {
  final EmberPlayerBody jugador;
  final double tamanoX, tamanoY;
  final double offsetX = 45.0;
  final double offsetY = 64.0;
  final double offsetXPaint = 101.25;
  final double offsetYPaint = 12.0;

  BarraVida(this.jugador, this.tamanoX, this.tamanoY);

  @override
  void render(Canvas c) {
    final barraVidaWidth = 450.0*tamanoX;
    final barraVidaHeight = 48.0*tamanoY;
    final vidaActualWidth = (jugador.iVidas / 3) * barraVidaWidth; // Considerando que iVidas va de 0 a 3

    // Dibujar el contorno de la barra de vida
    c.drawRect(
      Rect.fromPoints(
        Offset(offsetX*tamanoX, offsetY*tamanoY), // Añadir margen izquierdo y superior
        Offset(offsetX*tamanoX + barraVidaWidth, offsetY*tamanoY + barraVidaHeight), // Añadir margen izquierdo y superior
      ),
      Paint()..color = Colors.black,
    );

    // Dibujar la barra de vida actual
    c.drawRect(
      Rect.fromPoints(
        Offset(offsetX*tamanoX, offsetY*tamanoY), // Añadir margen izquierdo y superior
        Offset(offsetX*tamanoX + vidaActualWidth, offsetY*tamanoY + barraVidaHeight), // Añadir margen izquierdo y superior
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
    textPainter.paint(c, Offset(offsetXPaint*tamanoX, offsetYPaint*tamanoY)); // Ajustar posición según el diseño
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Mantener la posición de la barra de vida estática en la esquina superior izquierda con margen
    this.x = 0;
    this.y = 0;
  }
}