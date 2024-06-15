import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:map_game/actors/character.dart';

import '../main.dart';

class InteractComponent extends SpriteComponent with CollisionCallbacks, HasGameRef<MapGame>  {
  final Tile tile;
  final TiledImage image;
  final TiledObject object;

  InteractComponent(this.tile, this.image, this.object) : super(scale: Vector2.all(2.0), anchor: Anchor.bottomLeft);

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    x = object.x * 2;
    y = object.y * 2;
    size = Vector2(object.width, object.height);

    if(image.source != null) {
      sprite = Sprite(
        await Flame.images.load(image.source!),
        srcPosition: Vector2(tile.imageRect!.left, tile.imageRect!.top),
        srcSize: Vector2(object.width, object.height)
      );
    }
    add(RectangleHitbox());
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if(other is Character) {
      removeFromParent();
    }
  }
}