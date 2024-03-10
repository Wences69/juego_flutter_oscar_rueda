import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../games/OscarGame.dart';

// Ember
class EmberPlayer extends SpriteAnimationComponent with HasGameRef<OscarGame> {
  EmberPlayer({
    required super.position,
    required super.size
  }) : super(anchor: Anchor.center);

  @override
  void onLoad() {
    // Configurar la animación de Ember
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

// Cuerpo físico
class EmberPlayerBody extends BodyComponent with KeyboardHandler, ContactCallbacks {
  final Vector2 velocidad = Vector2.zero();
  final double aceleracion = 1000;
  late int iTipo = -1;
  late Vector2 tamano;
  int horizontalDirection = 0;
  int verticalDirection = 0;
  late EmberPlayer emberPlayer;
  late double jumpSpeed = 0.0;
  Vector2 initialPosition;
  bool blEspacioLiberado = true;
  int iVidas = 3;

  LogicalKeyboardKey keyIzquierda;
  LogicalKeyboardKey keyArriba;
  LogicalKeyboardKey keyAbajo;
  LogicalKeyboardKey keyDerecha;

  // Constructor
  EmberPlayerBody({
    required this.initialPosition,
    required this.tamano,
    required this.keyIzquierda,
    required this.keyArriba,
    required this.keyAbajo,
    required this.keyDerecha,
  }) : super();

  @override
  Body createBody() {
    // Crear el cuerpo físico
    BodyDef definicionCuerpo = BodyDef(
      position: initialPosition,
      type: BodyType.dynamic,
      angularDamping: 0.8,
      userData: this,
    );

    Body cuerpo = world.createBody(definicionCuerpo);

    final shape = CircleShape();
    shape.radius = tamano.x / 2;

    FixtureDef fixtureDef = FixtureDef(
      shape,
      restitution: 0.5,
      userData: this,
    );

    cuerpo.createFixture(fixtureDef);

    return cuerpo;
  }

  @override
  Future<void> onLoad() {
    renderBody = false;
    emberPlayer = EmberPlayer(position: Vector2(0, 0), size: tamano);
    add(emberPlayer);
    return super.onLoad();
  }

  void onTapDown(_) {
    // Aplicar impulso al tocar la pantalla
    body.applyLinearImpulse(Vector2.random() * 5000);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // Eventos de teclado
    horizontalDirection = 0;
    verticalDirection = 0;

    final bool isKeyDown = event is RawKeyDownEvent;
    final bool isKeyUp = event is RawKeyUpEvent;

    if (isKeyDown) {
      if (keysPressed.contains(keyIzquierda) && keysPressed.contains(keyAbajo)) {
        horizontalDirection = -3;
        verticalDirection = 3;
      } else if (keysPressed.contains(keyDerecha) && keysPressed.contains(keyAbajo)) {
        horizontalDirection = 3;
        verticalDirection = 3;
      } else if (keysPressed.contains(keyDerecha) && keysPressed.contains(keyArriba)) {
        horizontalDirection = 3;
        verticalDirection = -3;
      } else if (keysPressed.contains(keyIzquierda) && keysPressed.contains(keyArriba)) {
        horizontalDirection = -3;
        verticalDirection = -3;
      } else if (keysPressed.contains(keyDerecha)) {
        horizontalDirection = 3;
      } else if (keysPressed.contains(keyIzquierda)) {
        horizontalDirection = -3;
      } else if (keysPressed.contains(keyAbajo)) {
        verticalDirection = 3;
      } else if (keysPressed.contains(keyArriba)) {
        verticalDirection = -3;
      }

      if (keysPressed.contains(LogicalKeyboardKey.space)) {
        if (blEspacioLiberado) {
          blEspacioLiberado = false;
          body.gravityOverride = Vector2(0, -40);
        }
      }
    } else if (isKeyUp) {
      blEspacioLiberado = true;
      body.gravityOverride = Vector2(0, 40);
    }
    return true;
  }

  @override
  void update(double dt) {
    // Actualizar la posición y la animación
    velocidad.x = horizontalDirection * aceleracion;
    velocidad.y = verticalDirection * aceleracion;

    initialPosition += velocidad * dt;
    body.applyLinearImpulse(velocidad * dt * 1000);

    if (horizontalDirection < 0 && emberPlayer.scale.x > 0) {
      emberPlayer.flipHorizontallyAroundCenter();
    } else if (horizontalDirection > 0 && emberPlayer.scale.x < 0) {
      emberPlayer.flipHorizontallyAroundCenter();
    }
    super.update(dt);
  }
}