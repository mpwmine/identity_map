
import 'dart:async';

import 'package:flame/components.dart' hide Timer;
import 'package:map_game/actors/character.dart';
import 'package:map_game/main.dart';
import 'package:map_game/question.dart';
import 'package:map_game/world/interact.dart';
import 'package:map_game/world/wall.dart';

class FishComponent extends InteractComponent with HasGameReference<MapGame> {
  FishComponent(super.tile, super.image, super.object);

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if(other is Character) {
      gameRef.scoreAdd(5);
      gameRef.overlays.add("phished");
      Timer(Duration(milliseconds: 500), () {
        gameRef.overlays.remove('phished');
      });
    }
    super.onCollisionStart(intersectionPoints, other);
  }
 
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
     if ((other is Wall || other is InvisibleWall) && intersectionPoints.length == 2) {
      // Calculate the collision normal and separation distance.
      final mid = (intersectionPoints.elementAt(0) +
          intersectionPoints.elementAt(1)) / 2;

      final collisionNormal = absoluteCenter - mid;
      final separationDistance = (size.x * 0.51) - collisionNormal.length;
      collisionNormal.normalize();

      // Resolve collision by moving ember along
      // collision normal by separation distance.
      position -= collisionNormal.scaled(separationDistance);
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    final v = gameRef.character.position - position;
    if(v.length < 6*64) {
      position += v.normalized() * 100 * dt;
    } 


  }

}