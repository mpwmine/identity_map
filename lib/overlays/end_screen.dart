import 'dart:async';

import 'package:flutter/material.dart';
import 'package:map_game/main.dart';

class EndScreenOverlay extends StatefulWidget {
  final MapGame game;

  const EndScreenOverlay(this.game, {super.key});

  @override
  State<EndScreenOverlay> createState() => _EndScreenOverlayState();
}

class _EndScreenOverlayState extends State<EndScreenOverlay> {
  int? answer;
  bool? answerCorrect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String riskLevel;
    if(widget.game.score <= 30) {
      riskLevel = "Low risk";
    }
    else if(widget.game.score <= 70) {
      riskLevel = "Medium risk";
    }
    else {
      riskLevel = "High risk";
    }

    return Container(
          padding: EdgeInsets.all(40),
          width: double.infinity,
          color: Colors.black54,
          child: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 7, 20, 106),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(color: Colors.white)
              ),
              padding: EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  if(widget.game.questionTitle != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text("Well Done you have finished the game", style: theme.textTheme.displayMedium?.copyWith(color: Colors.white),),
                    ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text("Risk points: ${widget.game.score}" + "\n" +
                        "Risk level: ${riskLevel}" + "\n\n" +
                        "Remember, these are ways of preventing identity theft:\n" +
                        "Shread all mail you throw away,\n" +
                        "Only click on secure links,\n" +
                        "Keep docuents such as your driving licence safe and,\n" +
                        "Don't give out personal identifying information online", style: theme.textTheme.headlineMedium?.copyWith(color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            widget.game.resetGame();
                            widget.game.overlays.remove('end_screen');
                          }, 
                          child: Text("Play again")
                        ),
                      )
      
                ],
              ),
            ),
          ),
    
    );
  }
}
