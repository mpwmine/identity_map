
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flame/image_composition.dart';
import 'package:flutter/services.dart';
import 'package:map_game/main.dart';
import 'package:map_game/world/interact.dart';
import 'package:map_game/world/wall.dart';

class Character extends SpriteAnimationComponent
    with KeyboardHandler, CollisionCallbacks, HasGameRef<MapGame> {
  final Image image;
  bool flipped = false;
  bool collided = false;
  JoystickDirection collidedDirectionX = JoystickDirection.idle;
  JoystickDirection collidedDirectionY = JoystickDirection.idle;
  final animations = <SpriteAnimation>[];
  int _direction = 0;
  static const DOWN = 0;
  static const UP = 2;
  static const RIGHT = 1;
  static const LEFT = 3;
  int keyboardX = 0;
  int keyboardY = 0;
  
  final animationMap = <JoystickDirection,int>{
    JoystickDirection.down: 0,
    JoystickDirection.right: 1,
    JoystickDirection.upRight: 1,
    JoystickDirection.downRight: 1,
    JoystickDirection.left: 2,
    JoystickDirection.upLeft: 2,
    JoystickDirection.downLeft: 2,
    JoystickDirection.up: 3,
    JoystickDirection.idle: -1
  };
  final collidingObjects = <PositionComponent, List<int>>{};

  Character(this.image) : super(size: Vector2(64, 64))  {
    for(int i=0; i<4; i++) {
      animations.add(SpriteAnimation.fromFrameData(
          image,
          SpriteAnimationData.sequenced(
              amount: 4,
              stepTime: 0.1,
              textureSize: Vector2(48,80),
              texturePosition: Vector2(0, 80.0*i)
          )
      ));
    }
    animation = animations.first;
  }

  set direction(int value) {
    if(_direction != value && value >=0 && value < 4) {
      animation = animations[value];
      _direction = value;
    }
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    keyboardX = 0;
    keyboardX += (keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft))
        ? -1
        : 0;
    keyboardX += (keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight))
        ? 1
        : 0;

    keyboardY += (keysPressed.contains(LogicalKeyboardKey.keyW) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft))
        ? -1
        : 0;
    keyboardY += (keysPressed.contains(LogicalKeyboardKey.keyS) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight))
        ? 1
        : 0;
    return true;
  }

  int get direction => _direction;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox());
    debugMode = false;
  }

  @override
  void update(double dt) {
    super.update(dt);
    final direction = animationMap[gameRef.joystick.direction] ?? -1;



    final double vectorX = (gameRef.joystick.relativeDelta * 300 * dt)[0];
    final double vectorY = (gameRef.joystick.relativeDelta * 300 * dt)[1];

    final collideDirections = <int>{};
    collidingObjects.forEach((k,v) => collideDirections.addAll(v));

    position += Vector2(vectorX, vectorY);
    position += Vector2(keyboardX * 200 * dt, keyboardY * 200 *dt);

    if(direction == -1) {
      animationTicker?.paused = true;
    }else{
      animation = animations[direction];
      animationTicker?.paused = false;
    }
  }

  final Vector2 fromAbove = Vector2(0, -1);

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Wall && intersectionPoints.length == 2) {
      // Calculate the collision normal and separation distance.
      final mid = (intersectionPoints.elementAt(0) +
          intersectionPoints.elementAt(1)) / 2;

      final collisionNormal = absoluteCenter - mid;
      final separationDistance = (size.x * 0.55) - collisionNormal.length;
      collisionNormal.normalize();

      // If collision normal is almost upwards,
      // ember must be on ground.
      //if (fromAbove.dot(collisionNormal) > 0.9) {
        //isOnGround = true;
      //}

      // Resolve collision by moving ember along
      // collision normal by separation distance.
      position += collisionNormal.scaled(separationDistance);
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
  }
}