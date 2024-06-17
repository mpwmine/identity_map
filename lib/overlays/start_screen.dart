 import 'package:flutter/material.dart';
import 'dart:async';

import 'package:map_game/main.dart';

class StartScreenOverlay extends StatefulWidget {
  final MapGame game;

  const StartScreenOverlay(this.game, {super.key}); 
  @override
  State<StartScreenOverlay> createState() => _StartScreenOverlayState();
}


class _StartScreenOverlayState extends State <StartScreenOverlay> {
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
                color: Color.fromARGB(255, 7, 20, 106),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(color: Colors.white)
              ),
              padding: EdgeInsets.all(10.0),
              child: ListView(
                children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text("This is Identity theft game", style: theme.textTheme.displayMedium?.copyWith(color: Colors.white),),
                    ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 200.0),
                        child: Text("Use the Joystick or WASD keys to contol,\n" +
                        "Try to keep your risk points (top right corner) low\n" +
                        "If you get to the end with less than 30 risk points you have low risk of identity theft \n" +
                        "If it is between 31 and 70 you are medium risk and above 71 is high risk \n" +
                        "The fish will try to Phish you, so try to avoid them\n" +
                        "Enjoy!" , style: theme.textTheme.headlineMedium?.copyWith(color: Colors.white),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            widget.game.resetGame();
                            widget.game.overlays.remove('start_screen');
                          }, 
                          child: Text("Play!")
                        ),
                      )
      
                ],
              ),
            ),
          ),
    
    );
  }
}