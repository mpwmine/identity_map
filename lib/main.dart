import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart';
import 'package:flame/palette.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:map_game/actors/character.dart';
import 'package:map_game/overlays/Phishing.dart';
import 'package:map_game/overlays/end_screen.dart';
import 'package:map_game/overlays/score.dart';
import 'package:map_game/overlays/start_screen.dart';
import 'package:map_game/question.dart';
import 'package:map_game/world/death.dart';
import 'package:map_game/world/interact.dart';
import 'package:map_game/world/wall.dart';
import 'package:map_game/world/interactions.dart';

import 'overlays/question.dart';

Widget questionBuilder(BuildContext context, MapGame game) {
  return QuestionOverlay(game);
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GameWidget(
          game: MapGame(),
          overlayBuilderMap: {
              'question': questionBuilder,
              'score': (BuildContext context, MapGame game) { return ScoreOverlay(game); },
              'phished': (BuildContext context, MapGame game) { return PhishedOverlay(game); },
              'end_screen': (BuildContext context, MapGame game) { 
                return EndScreenOverlay(game); 
              },
              'start_screen': (BuildContext context, MapGame game) { 
                return StartScreenOverlay(game); 
              },
          },
        ),
      )),
  );
}

class MapGame extends FlameGame with HasCollisionDetection, HasKeyboardHandlerComponents {
  late final JoystickComponent joystick;
  late Character character;
  Question? currentQuestion;
  String? questionTitle;
  int score = 0;
  Vector2 returnPosition = Vector2(64,64);
  final worldSize = Vector2(300*64, 200*64);
  final questionSeen = <Question>[];
  
  MapGame() :
      super(
        world: MapWorld()
      );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    overlays.add("start_screen");


    camera.viewfinder
      ..zoom = 1.0
      ..anchor = Anchor.center;

    final Image characterImage = await Flame.images.load('character.png');
    character = Character(characterImage)
      ..position = returnPosition
      ..direction = 1
      ..priority = 100;
    world.add(character);

    camera.follow(character);

    final knobPaint = BasicPalette.blue.withAlpha(100).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(50).paint();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 30, paint: knobPaint),
      background: CircleComponent(radius: 100, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 40, top: 200),
      priority: 1,
    );
    camera.viewport.add(joystick);
    overlays.add('score');
  }

  void scoreAdd([int value=10]) {
    score += value;
    overlays.remove('score');
    overlays.add('score');
  }

  void resetGame() {
    score = 0;
    questionSeen.clear();
    returnPosition = character.position = Vector2(64, 64);
    currentQuestion = null;
    questionTitle = null;
    (world as MapWorld).setInteractions();
  }
}

class MapWorld extends World {
  late TiledComponent<FlameGame<World>> homeMap;

  @override
  Future<void> onLoad() async {
    homeMap = await TiledComponent.load('map.tmx', Vector2.all(64));

    add(homeMap);
    final walls = WallGroup( homeMap.tileMap.getLayer<TileLayer>('Walls'), Vector2.all(64));
    add(walls);
    final deaths = DeathGroup( homeMap.tileMap.getLayer<TileLayer>('Death'), Vector2.all(64));
    add(deaths);
    
    setInteractions();

    super.onLoad();
  }

  void setInteractions() {
     removeWhere((a) => a is InteractComponent);
    final manager = InteractionManager( homeMap.tileMap.getLayer<ObjectGroup>('Interactions')!,   homeMap.tileMap.map, Vector2.all(64));
    for(final c in manager.compnents) {
      add(c);
    }
  }
}