


import 'package:flame/components.dart';
import 'package:map_game/actors/character.dart';
import 'package:map_game/main.dart';
import 'package:map_game/question.dart';
import 'package:map_game/world/interact.dart';

class EmailComponent extends InteractComponent with HasGameReference<MapGame> {
  EmailComponent(super.tile, super.image, super.object);

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if(other is Character) {
      gameRef.currentQuestion = QuestionList.randomQuestion();
      gameRef.questionTitle = 'You have just received and email? What are you going to do?';
      gameRef.overlays.add('question');
      gameRef.returnPosition = position;
    }
    super.onCollisionStart(intersectionPoints, other);
  }


}