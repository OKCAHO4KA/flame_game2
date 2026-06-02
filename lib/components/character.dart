import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

enum MovementType {
  idle,
  walkingRight,
  walkingLeft,
  walkingUp,
  walkingDown,
  runRight,
  runLeft,
  runUp,
  runDown,
}

class Character extends SpriteAnimationComponent
    with KeyboardHandler, CollisionCallbacks {
  MovementType movementType = MovementType.idle;
}

double speed = 40;

bool isMoving = false;

final double spriteSheetWidth = 128;
final double spriteSheetHeight = 128;

late SpriteAnimation idleAnimation,
    rightAnimation,
    leftAnimation,
    upAnimation,
    downAnimation;

late RectangleHitbox body;
