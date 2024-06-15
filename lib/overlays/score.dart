


import 'package:flutter/material.dart';
import 'package:map_game/main.dart';

class ScoreOverlay extends StatelessWidget {
  final MapGame game;
  const ScoreOverlay(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Positioned(
          top: 10.0,
          right: 10.0,
          child: Text(game.score.toString(), style: theme.textTheme.headlineMedium?.copyWith(color: Colors.white), textAlign: TextAlign.right,)
        )
      ],
    );
  }
}