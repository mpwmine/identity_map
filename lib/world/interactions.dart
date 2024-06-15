

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:map_game/world/email.dart';
import 'package:map_game/world/interact.dart';

class InteractionManager {
  final ObjectGroup group;
  final TiledMap tileMap;
  final Vector2 tileSize;
  final compnents = <Component>[];

  InteractionManager(this.group, this.tileMap, this.tileSize) {
    for(final o in group.objects) {
      if(o.gid != null) {
        final tileset = tileMap.tilesetByTileGId(o.gid!);
        final tile = tileMap.tileByGid(o.gid!);
        if(tile != null) {
          final image = tile.image ?? tileset.image;
          if(image != null) {
            switch( o.class_ ) {
              case "email":
                compnents.add(EmailComponent(tile, image, o));
                break;

              default:
                compnents.add(InteractComponent(tile, tileset.image!, o));
                break;
            }



          }
        }
      }
    }
  }

  
}