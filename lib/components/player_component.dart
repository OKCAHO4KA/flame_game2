import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:world_xy/components/character.dart';
import 'package:world_xy/main.dart';
import 'package:world_xy/utils/create_animation_by_limit.dart';

class PlayerComponent extends Character {
  MyGame game;

  PlayerComponent({required this.game}) : super() {
    debugMode = true;
  }

  @override
  FutureOr<void> onLoad() async {
    final spriteImage = await Flame.images.load('monster.png');
    final spriteSheet = SpriteSheet(
      image: spriteImage,
      srcSize: Vector2(spriteSheetWidth, spriteSheetHeight),
    );

    idleAnimation = spriteSheet.createAnimationByLimit(
      xInit: 0,
      yInit: 0,
      step: 4,
      sizeX: 8,
      stepTime: .2,
    );

    leftAnimation = spriteSheet.createAnimationByLimit(
      xInit: 1,
      yInit: 0,
      step: 4,
      sizeX: 8,
      stepTime: .2,
    );

    rightAnimation = spriteSheet.createAnimationByLimit(
      xInit: 2,
      yInit: 0,
      step: 4,
      sizeX: 8,
      stepTime: .2,
    );
    upAnimation = spriteSheet.createAnimationByLimit(
      xInit: 3,
      yInit: 0,
      step: 4,
      sizeX: 8,
      stepTime: .2,
    );

    downAnimation = spriteSheet.createAnimationByLimit(
      xInit: 0,
      yInit: 0,
      step: 4,
      sizeX: 8,
      stepTime: .2,
    );

    reset();
  }

  void reset() {
    animation = idleAnimation;
    position = Vector2(spriteSheetWidth, spriteSheetHeight);
    size = Vector2(spriteSheetWidth, spriteSheetHeight);
    movementType = MovementType.idle;
  }
}
