

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class InteractionManager {
  final ObjectGroup group;
  final Vector2 tileSize;
  final compnents = <Component>[];

  InteractionManager(this.group, this.tileSize) {
    for(final o in this.group.objects) {
      print(o);
    }

  }

  
}