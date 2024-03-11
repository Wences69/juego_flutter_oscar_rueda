import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'EmberPlayer.dart';

class BarraVida2 extends PositionComponent {
  final EmberPlayerBody jugador;
  final double sizeX, sizeY;
  final double offsetX = 45.0;
  final double offsetY = 64.0;
  final double offsetXPaint = 101.25;
  final double offsetYPaint = 12.0;

  // Constructor
  BarraVida2(
      this.jugador,
      this.sizeX,
      this.sizeY
      );

  @override
  void render(Canvas canvas) {
    final barraVidaWidth = 450.0 * sizeX;
    final barraVidaHeight = 48.0 * sizeY;
    final vidaActualWidth = (jugador.iVidas / 3) * barraVidaWidth;

    // Dibujar el contorno de la barra de vida
    canvas.drawRect(
      Rect.fromPoints(
        Offset(offsetX * sizeX - 1, offsetY * sizeY - 1),
        Offset(offsetX * sizeX + barraVidaWidth + 2, offsetY * sizeY + barraVidaHeight + 2),
      ),
      Paint()..color = Colors.black,
    );

    // Dibujar la barra de vida actual
    canvas.drawRect(
      Rect.fromPoints(
        Offset(offsetX * sizeX, offsetY * sizeY),
        Offset(offsetX * sizeX + vidaActualWidth, offsetY * sizeY + barraVidaHeight),
      ),
      Paint()..color = Colors.green,
    );

    // Dibujar el texto encima de la barra de vida
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'Vidas del jugador2: ${jugador.iVidas}',
        style: TextStyle(color: Colors.white, fontSize: 36 * sizeX),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(canvas, Offset(offsetXPaint * sizeX, offsetYPaint * sizeY));
  }

  @override
  void update(double dt) {
    super.update(dt);

    x = 1200  ;
    y = 0;
  }
}
