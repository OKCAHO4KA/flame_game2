import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:world_xy/components/player_component.dart';
import 'package:world_xy/maps/tile_map_component.dart';

class MyGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  late final CameraComponent? cameraComponent;
  late final PlayerComponent player;
  late final TileMapComponent background;

  @override
  final world = World();

  @override
  Future<void> onLoad() async {
    //сначала добавляем мир
    await add(world);

    //создаем и ждем полную загрузку карты
    background = TileMapComponent();
    await world.add(background);

    //создаем игрока после загрузки карты, чтобы получить ее размеры для камеры
    player = PlayerComponent(game: this);
    await world.add(player);

    // Инициализируем и добавляем камеру в сам FlameGame
    cameraComponent = CameraComponent(world: world);
    cameraComponent!.follow(player);
    // cameraComponent!.setBounds(
    //   Rectangle.fromLTRB(
    //     0,
    //     0,
    //     background.tiledMap.size.x,
    //     background.tiledMap.size.y,
    //   ),
    // );
    // cameraComponent!.setBounds(
    //   Rectangle.fromCenter(
    //     center: background.tiledMap.size / 2,
    //     size: background.tiledMap.size - cameraComponent!.viewport.size,
    //   ),
    // );

    cameraComponent!.setBounds(
      Rectangle.fromLTRB(
        0,
        0,
        background.tiledMap.size.x,
        background.tiledMap.size.y,
      ),
    );
    await add(
      cameraComponent!,
    ); // Камера добавляется в корневой Game, а не в World

    // 5. Добавляем хитбокс экрана для коллизий
    await world.add(ScreenHitbox());
    super.onLoad();
  }

  @override
  Color backgroundColor() {
    return Colors.teal;
  }
}

void main() {
  runApp(GameWidget(game: MyGame()));
}
