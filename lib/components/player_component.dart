import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';
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

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.isEmpty) {
      movementType = MovementType.idle;
      isMoving = false;
    } else {
      isMoving = true;
    }
    //____RIGHT_____
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight) ||
        keysPressed.contains(LogicalKeyboardKey.keyD)) {
      if (keysPressed.contains(LogicalKeyboardKey.shiftLeft)) {
        movementType = MovementType.runRight;
      } else {
        movementType = MovementType.walkingRight;
      }
    }
    //____LEFT____
    else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) ||
        keysPressed.contains(LogicalKeyboardKey.keyA)) {
      if (keysPressed.contains(LogicalKeyboardKey.shiftLeft)) {
        movementType = MovementType.runLeft;
      } else {
        movementType = MovementType.walkingLeft;
      }
    }
    //____TOP_____
    else if (keysPressed.contains(LogicalKeyboardKey.arrowUp) ||
        keysPressed.contains(LogicalKeyboardKey.keyW)) {
      if (keysPressed.contains(LogicalKeyboardKey.shiftLeft)) {
        movementType = MovementType.runUp;
      } else {
        movementType = MovementType.walkingUp;
      }
    }
    //____BOTTOM_____
    else if (keysPressed.contains(LogicalKeyboardKey.arrowDown) ||
        keysPressed.contains(LogicalKeyboardKey.keyS)) {
      if (keysPressed.contains(LogicalKeyboardKey.shiftLeft)) {
        movementType = MovementType.runDown;
      } else {
        movementType = MovementType.walkingDown;
      }
    }

    return true;
  }

  void moveAnimation(double dt) {
    if (!isMoving) return;

    movePlayer(dt);

    switch (movementType) {
      case MovementType.idle:
        animation?.loop = false;
        animation = idleAnimation;
        break;
      case MovementType.walkingRight:
      case MovementType.runRight:
        _resetAnimation();
        animation = rightAnimation;
        break;
      case MovementType.walkingLeft:
      case MovementType.runLeft:
        _resetAnimation();
        animation = leftAnimation;
        break;
      case MovementType.walkingUp:
      case MovementType.runUp:
        _resetAnimation();
        animation = upAnimation;
        break;
      case MovementType.walkingDown:
      case MovementType.runDown:
        _resetAnimation();
        animation = downAnimation;
        break;
    }
  }

  void _resetAnimation() {
    if (animation?.loop == false) {
      print(animation?.loop);
      animation?.loop = true;
      // animation?.reset();
    }
  }

  void movePlayer(double dt) {
    switch (movementType) {
      case MovementType.idle:
        break;
      case MovementType.walkingRight:
      case MovementType.runRight:
        position.x += speed * dt;
        //position.add(Vector2(speed * dt, 0));
        break;
      case MovementType.runLeft:
      case MovementType.walkingLeft:
        position.x -= speed * 2 * dt;
        break;
      case MovementType.walkingUp:
      case MovementType.runUp:
        position.y -= speed * dt;
        break;
      case MovementType.walkingDown:
      case MovementType.runDown:
        position.y += speed * 2 * dt;
        break;
    }
  }

  void reset() {
    animation = idleAnimation;
    position = Vector2(spriteSheetWidth, spriteSheetHeight);
    size = Vector2(spriteSheetWidth, spriteSheetHeight);
    movementType = MovementType.idle;
  }

  @override
  update(double dt) {
    moveAnimation(dt);
    super.update(dt);
  }
}
