import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:world_xy/maps/tile/object_component.dart';
import 'package:world_xy/maps/tile/water_component.dart';

class TileMapComponent extends PositionComponent {
  late TiledComponent tiledMap;

  @override
  Future<void> onLoad() async {
    tiledMap = await TiledComponent.load(
      'map.tmx',
      Vector2.all(48),
    ); //у нас 48 на 48
    add(tiledMap);

    final objWater = tiledMap.tileMap.getLayer<ObjectGroup>('water_obj');

    for (final obj in objWater!.objects) {
      add(
        WaterComponent(
          size: Vector2(obj.width, obj.height),
          position: Vector2(obj.x, obj.y),
        ),
      );
    }
    final objObstacles = tiledMap.tileMap.getLayer<ObjectGroup>(
      'obstaculos_obj',
    );

    for (final obj in objObstacles!.objects) {
      add(
        ObjectComponent(
          size: Vector2(obj.width, obj.height),
          position: Vector2(obj.x, obj.y),
        ),
      );
    }
  }
}
