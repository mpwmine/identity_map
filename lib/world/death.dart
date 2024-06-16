


import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Death extends PositionComponent {
  
  Future<void> onLoad() async {
      add(RectangleHitbox(collisionType: CollisionType.passive));
  }
}

class DeathGroup extends PositionComponent {
  final TileLayer? tileLayer;
  final Vector2 tileSize;

  DeathGroup(this.tileLayer, this.tileSize) : super();

  Future<void> onLoad() async {
    if(tileLayer != null) {
      for (int y = 0; y < tileLayer!.height; y++) {
        for (int x = 0; x < tileLayer!.width; x++) {
          if (tileLayer!.tileData![y][x].tile > 0) {
            add(
              Death()
                ..position = Vector2(x * tileSize.x, y * tileSize.y)
                ..size = tileSize
            );
          }
        }
      }
    }

  }
}