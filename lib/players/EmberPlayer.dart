import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../games/OscarGame.dart';

class EmberPlayer extends SpriteAnimationComponent with HasGameRef<OscarGame> {

  EmberPlayer({
    required super.position, required super.size
  }) : super( anchor: Anchor.center);

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

class EmberPlayerBody extends BodyComponent with KeyboardHandler,ContactCallbacks{
  final Vector2 velocidad = Vector2.zero();
  final double aceleracion = 1000;
  late int iTipo=-1;
  late Vector2 tamano;
  int horizontalDirection = 0;
  int verticalDirection = 0;
  final _defaultColor = Colors.red;
  late EmberPlayer emberPlayer;
  late double jumpSpeed=0.0;
  Vector2 initialPosition;
  bool blEspacioLiberado=true;
  int iVidas=3;

  EmberPlayerBody({required this.initialPosition,
    required this.tamano})
      : super();

  @override
  Body createBody() {
    // TODO: implement createBody

    BodyDef definicionCuerpo= BodyDef(position: initialPosition,
        type: BodyType.dynamic,angularDamping: 0.8,userData: this);

    Body cuerpo= world.createBody(definicionCuerpo);


    final shape=CircleShape();
    shape.radius=tamano.x/2;

    FixtureDef fixtureDef=FixtureDef(
        shape,
        //density: 10.0,
        //friction: 0.2,
        restitution: 0.5, userData: this
    );
    cuerpo.createFixture(fixtureDef);

    return cuerpo;
  }

  @override
  Future<void> onLoad() {
    // TODO: implement onLoad

    emberPlayer=EmberPlayer(position: Vector2(0,0), size:tamano);
    add(emberPlayer);
    return super.onLoad();
  }

  @override
  void onTapDown(_) {
    body.applyLinearImpulse(Vector2.random() * 5000);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {


    // TODO: implement onKeyEvent

    horizontalDirection = 0;
    verticalDirection = 0;

    final bool isKeyDown = event is RawKeyDownEvent;
    final bool isKeyUp = event is RawKeyUpEvent;

    if(isKeyDown) {
      if (keysPressed.contains(LogicalKeyboardKey.keyA) &&
          keysPressed.contains(LogicalKeyboardKey.keyS)) {
        horizontalDirection = -3;
        verticalDirection = 3;
      }
      else if (keysPressed.contains(LogicalKeyboardKey.keyD) &&
          keysPressed.contains(LogicalKeyboardKey.keyS)) {
        horizontalDirection = 3;
        verticalDirection = 3;
      }

      else if (keysPressed.contains(LogicalKeyboardKey.keyD) &&
          keysPressed.contains(LogicalKeyboardKey.keyW)) {
        horizontalDirection = 3;
        verticalDirection = -3;
      }

      else if (keysPressed.contains(LogicalKeyboardKey.keyA) &&
          keysPressed.contains(LogicalKeyboardKey.keyW)) {
        horizontalDirection = -3;
        verticalDirection = -3;
      }

      else if (keysPressed.contains(LogicalKeyboardKey.keyD)) {
        horizontalDirection = 3;
      }

      else if (keysPressed.contains(LogicalKeyboardKey.keyA)) {
        horizontalDirection = -3;
      }

      else if (keysPressed.contains(LogicalKeyboardKey.keyS)) {
        verticalDirection = 3;
      }

      else if (keysPressed.contains(LogicalKeyboardKey.keyW)) {
        verticalDirection = -3;
      }

      if(keysPressed.contains(LogicalKeyboardKey.space)){
        if(blEspacioLiberado) { //jumpSpeed=2000;
          blEspacioLiberado = false;
          body.gravityOverride = Vector2(0, -40);
        }
        //this.bodyDef?.gravityOverride=Vector2(0, -20);
      }
    }
    else if(isKeyUp){
      blEspacioLiberado=true;
      body.gravityOverride = Vector2(0, 40);
      //}
    }
    return true;
  }

  @override
  void update(double dt) {
    // TODO: implement update
    /*velocidad.x = horizontalDirection * aceleracion; //v=a*t
    velocidad.y = verticalDirection * aceleracion; //v=a*t
     //d=v*t

    position.x += velocidad.x * dt; //d=v*t
    position.y += velocidad.y * dt; //d=v*t*/

    velocidad.x = horizontalDirection * aceleracion;
    velocidad.y = verticalDirection * aceleracion;

    initialPosition += velocidad * dt;

    /*velocidad.y += -1 * jumpSpeed;
    jumpSpeed=0;*/

    //center.add((velocity * dt));
    body.applyLinearImpulse(velocidad*dt*1000);

    //body.applyAngularImpulse(3);

    if (horizontalDirection < 0 && emberPlayer.scale.x > 0) {
      //flipAxisDirection(AxisDirection.left);
      //flipAxis(Axis.horizontal);
      emberPlayer.flipHorizontallyAroundCenter();
    } else if (horizontalDirection > 0 && emberPlayer.scale.x < 0) {
      //flipAxisDirection(AxisDirection.left);
      emberPlayer.flipHorizontallyAroundCenter();
    }

    super.update(dt);
  }
}