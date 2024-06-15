import 'dart:async';

import 'package:flutter/material.dart';
import 'package:map_game/main.dart';

class QuestionOverlay extends StatefulWidget {
  final MapGame game;

  const QuestionOverlay(this.game, {super.key});

  @override
  State<QuestionOverlay> createState() => _QuestionOverlayState();
}

class _QuestionOverlayState extends State<QuestionOverlay> {
  int? answer;
  bool? answerCorrect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(40),
      width: double.infinity,
      color: Colors.black54,
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.brown,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: Colors.white)
          ),
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              if(widget.game.questionTitle != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(widget.game.questionTitle!, style: theme.textTheme.headlineMedium?.copyWith(color: Colors.white),),
                ),
                if(widget.game.currentQuestion != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(widget.game.currentQuestion!.question, style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white),),
                  ),
                if(widget.game.currentQuestion != null)
                  for(final a in widget.game.currentQuestion!.answers.indexed)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        style: answer!=null && answer==a.$1 && answerCorrect!=null ?
                          ButtonStyle(backgroundColor: WidgetStateProperty.all(answerCorrect! ?  Colors.green : Colors.red.shade300 ) )
                          : null,
                        onPressed: () {
                          setState(() {
                            answer = a.$1;
                            answerCorrect = a.$1 == widget.game.currentQuestion!.correctAnswer;
                            if(!answerCorrect!) {
                              widget.game.scoreAdd();
                            }
                          });
                          Timer(Duration(milliseconds: 600), () {
                            widget.game.overlays.remove('question');
                          });
                        }, 
                        child: Text(a.$2)
                      ),
                    )

            ],
          ),
        ),
      ),
    );
  }
}
