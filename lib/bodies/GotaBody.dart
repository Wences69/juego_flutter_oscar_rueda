import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:forge2d/src/dynamics/body.dart';

import '../elementos/Gota.dart';
import '../games/OscarGame.dart';

class GotaBody extends BodyComponent<OscarGame> with ContactCallbacks {
  // Posición inicial
  Vector2 posXY;

  // Tamaño del cuerpo
  Vector2 sizeWH;

  // Variables para la animación
  double xIni = 0;
  double xFin = 0;
  double xContador = 0;
  double dAnimDireccion = -1;
  double dVelocidadAnim = 1;

  // Tamaño
  double gotaSize;

  // Tamaño predeterminado de la gota
  final double tamanoPred = 15.75;

  // Constructor
  GotaBody({
    required this.posXY,
    required this.sizeWH,
    required this.gotaSize
  }) : super();

  @override
  Body createBody() {
    BodyDef bodyDef = BodyDef(
      type: BodyType.dynamic,
      position: posXY,
      gravityOverride: Vector2(0, 0),
    );
    Body cuerpo = world.createBody(bodyDef);
    CircleShape shape = CircleShape();
    shape.radius = sizeWH.x / 2;
    Fixture fix = cuerpo.createFixtureFromShape(shape);
    fix.userData = this;
    return cuerpo;
  }

  // Método para cargar recursos y configurar la animación
  @override
  Future<void> onLoad() async {
    renderBody = false;
    await super.onLoad();

    // Crear y agregar la representación visual de la gota al componente
    Gota gotaPlayer = Gota(position: Vector2.all(-(tamanoPred * gotaSize)), size: sizeWH);
    add(gotaPlayer);

    // Inicializar variables de animación
    xIni = posXY.x;
    xFin = 40;
    xContador = 0;
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}