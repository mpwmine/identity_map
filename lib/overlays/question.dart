import 'package:flutter/material.dart';
import 'package:map_game/main.dart';

class QuestionOverlay extends StatelessWidget {
  const QuestionOverlay(MapGame game, {super.key});

  @override
  Widget build(BuildContext context) {
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
              Text('Hello')
            ],
          ),
        ),
      ),
    );
  }
}
