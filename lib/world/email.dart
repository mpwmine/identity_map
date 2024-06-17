


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
      while(true) {
        gameRef.currentQuestion = QuestionList.randomQuestion();
        if(gameRef.questionSeen.length >= QuestionList.questions.length) {
          gameRef.questionSeen.clear();
        }
        if(!gameRef.questionSeen.contains( gameRef.currentQuestion )) {
          gameRef.questionSeen.add( gameRef.currentQuestion! );
          break;
        }
      }
      if (gameRef.currentQuestion!.type == 'situation') {
        gameRef.questionTitle = 'What do you do in this situation';
      }
      else{
        gameRef.questionTitle = 'You have recieved an email. What do you do?';
      }
        
      gameRef.overlays.add('question');
      gameRef.returnPosition = position;
    }
    super.onCollisionStart(intersectionPoints, other);
  }


}