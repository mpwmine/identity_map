

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:map_game/world/email.dart';
import 'package:map_game/world/fast_fish.dart';
import 'package:map_game/world/fish.dart';
import 'package:map_game/world/interact.dart';
import 'package:map_game/world/wall.dart';

class InteractionManager {
  final ObjectGroup group;
  final TiledMap tileMap;
  final Vector2 tileSize;
  final compnents = <Component>[];

  InteractionManager(this.group, this.tileMap, this.tileSize) {
    for(final o in group.objects) {
      if( o.class_ == 'invisible_wall') {
        compnents.add(InvisibleWall(o));       
      }else if( o.class_ == 'end_screen') {
        compnents.add(EndScreen(o));       
      }else if(o.gid != null) {
        final tileset = tileMap.tilesetByTileGId(o.gid!);
        final tile = tileMap.tileByGid(o.gid!);
        if(tile != null) {
          final image = tile.image ?? tileset.image;
          if(image != null) {
            switch( o.class_ ) {
              case "email":
                compnents.add(EmailComponent(tile, image, o));
                break;
              case "fish":
                compnents.add(FishComponent(tile, image, o));
                break;
              case "fast_fish":
                compnents.add(Fast_FishComponent(tile, image, o));
                break;
            
              default:
                compnents.add(InteractComponent(tile, image, o));
                break;
            }
          }
        }
      }
    }
  }

  
}