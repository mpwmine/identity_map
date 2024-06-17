


import 'package:flutter/material.dart';
import 'package:map_game/main.dart';

class PhishedOverlay extends StatelessWidget {
  final MapGame game;
  const PhishedOverlay(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Positioned(
          top: 10.0,
          left: 10.0,
          right: 10.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [ 
              Text("You've been Phished!", style: theme.textTheme.headlineMedium?.copyWith(color: Colors.white), textAlign: TextAlign.center,)
            ]
          )
        )
      ],
    );
  }
}