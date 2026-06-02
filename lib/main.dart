import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:world_xy/components/player_component.dart';

class MyGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  @override
  Future<void> onLoad() async {
    var player = PlayerComponent(game: this);
    add(player);
    add(ScreenHitbox());

    super.onLoad();
  }

  @override
  backgroundColor() {
    super.backgroundColor();
    return Colors.teal;
  }
}

void main() {
  runApp(GameWidget(game: MyGame()));
}
