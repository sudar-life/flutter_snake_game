import 'package:flutter/material.dart';
import 'package:snake_game/src/model/game_state.dart';

class Player extends StatelessWidget {
  final List<Offset> tails;
  final double size;
  final Direction direction;
  const Player({
    super.key,
    required this.size,
    required this.tails,
    required this.direction,
  });

  @override
  Widget build(BuildContext context) {
    var angle = 0.0;
    switch (direction) {
      case Direction.left:
        angle = 0.25;
        break;
      case Direction.right:
        angle = 0.75;
        break;
      case Direction.up:
        angle = 0.5;
        break;
      case Direction.down:
        angle = 0.0;
        break;
    }
    return Stack(
        children: List.generate(tails.length, (index) {
      return AnimatedContainer(
        alignment: Alignment(tails[index].dx, tails[index].dy),
        duration: const Duration(milliseconds: 100),
        child: index == 0
            ? AnimatedRotation(
                duration: const Duration(milliseconds: 100),
                turns: angle,
                child: Image.asset(
                  'assets/images/head.png',
                  width: 40,
                  height: 40,
                ))
            : Image.asset(
                'assets/images/body.png',
                width: 30,
                height: 30,
              ),
      );
    }));
  }
}
