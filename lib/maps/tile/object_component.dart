import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class ObjectComponent extends PositionComponent {
  ObjectComponent({required Vector2 size, required Vector2 position})
    : super(size: size, position: position) {
    debugMode = true;
    add(RectangleHitbox()..collisionType = CollisionType.passive);
  }
}
