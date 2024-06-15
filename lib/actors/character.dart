
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flame/image_composition.dart';
import 'package:map_game/main.dart';
import 'package:map_game/world/interact.dart';
import 'package:map_game/world/wall.dart';

class Character extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<MapGame> {
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
    
    if(direction != -1) {
      if (vectorX < 0 && x > 0) {
        if (!collideDirections.contains(LEFT)) {
          x += vectorX;
        }
      }
      if (vectorX > 0 && x < gameRef.size[0]) {
        if (!collideDirections.contains(RIGHT)) {
          x += vectorX;
        }
      }
      if (vectorY < 0 && y > 0) {
        if (!collideDirections.contains(UP)) {
          y += vectorY;
        }
      }
      if (vectorY > 0 && y < gameRef.size[1]) {
        if (!collideDirections.contains(DOWN)) {
          y += vectorY;
        }
      }
    }

    if(direction == -1) {
      animationTicker?.paused = true;
    }else{
      animation = animations[direction];
      animationTicker?.paused = false;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Wall) {
        collidingObjects[other] = <int>[];
        for(final p in intersectionPoints) {
          if(p[0] < x+32) {
            if(!collidingObjects[other]!.contains(LEFT)) {
              collidingObjects[other]!.add(LEFT);
            }
          }else if(p[0] > x+32) {
            if(!collidingObjects[other]!.contains(RIGHT)) {
              collidingObjects[other]!.add(RIGHT);
            }
          }
          if(p[1] < y+32) {
            if(!collidingObjects[other]!.contains(UP)) {
              collidingObjects[other]!.add(UP);
            }
          }else if(p[1] > y+32) {
            if(!collidingObjects[other]!.contains(DOWN)) {
              collidingObjects[other]!.add(DOWN);
            }
          }
        }
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (other is Wall) {
      if(collidingObjects.containsKey(other)) {
        collidingObjects.remove(other);
      }
    }
  }
}