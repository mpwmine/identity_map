


import 'package:flame/components.dart';
import 'package:map_game/actors/character.dart';
import 'package:map_game/world/interact.dart';

class EmailComponent extends InteractComponent {
  EmailComponent(super.tile, super.image, super.object);

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if(other is Character) {
      gameRef.overlays.add('question');
    }
    super.onCollisionStart(intersectionPoints, other);
  }


}