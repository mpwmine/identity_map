import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart';
import 'package:flame/palette.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:map_game/actors/character.dart';
import 'package:map_game/world/wall.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  runApp(GameWidget(game: MapGame()));
}

class MapGame extends FlameGame with HasCollisionDetection {
  late Character character;
  late final JoystickComponent joystick;
  
  MapGame() :
      super(
        camera: CameraComponent.withFixedResolution(width: 28*32, height: 14*32),
      );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    camera.viewfinder
      ..zoom = 1.0
      ..anchor = Anchor.center;

    final homeMap = await TiledComponent.load('map.tmx', Vector2.all(64));
    add(homeMap);
    final walls = Wall( homeMap.tileMap.getLayer<TileLayer>('Walls'), Vector2.all(64));
    add(walls);

    final Image characterImage = await images.load('character.png');
    character = Character(characterImage)
          ..position = Vector2(64,64)
          ..direction = 1;
    add(character);

    final knobPaint = BasicPalette.blue.withAlpha(100).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(50).paint();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 30, paint: knobPaint),
      background: CircleComponent(radius: 100, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );
    add(joystick);
  }

}