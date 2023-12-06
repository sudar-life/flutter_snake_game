import 'dart:async';

import 'package:flutter/material.dart';
import 'package:snake_game/src/model/game_state.dart';

class Player extends StatefulWidget {
  final StreamController gameController;
  const Player({super.key, required this.gameController});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  int level = 5;
  double size = 40;
  late GameState gameState;
  List<Offset> tails = [];

  @override
  void initState() {
    super.initState();
    tails = [Offset.zero];
    widget.gameController.stream.listen((event) {
      gameState = event as GameState;
      if (gameState.status == GameStatus.run) {
        _moveCharactor();
        _checkCollision();
        update();
      }
    });
  }

  void _checkCollision() {
    _gameLineCollision(tails.first);
  }

  void _gameLineCollision(Offset position) {
    //left Line Over Check
    if (position.dx <= -1 ||
        position.dx >= 1 ||
        position.dy <= -1 ||
        position.dy >= 1) {
      widget.gameController.sink
          .add(gameState.copyWith(status: GameStatus.gameOver));
    }
  }

  void _moveCharactor() {
    var newPosition = tails.first;
    switch (gameState.keyboradDirection) {
      case Direction.left:
        newPosition = Offset(newPosition.dx - 0.01, newPosition.dy);
        break;
      case Direction.right:
        newPosition = Offset(newPosition.dx + 0.01, newPosition.dy);
        break;
      case Direction.up:
        newPosition = Offset(newPosition.dx, newPosition.dy - 0.01);
        break;
      case Direction.down:
        newPosition = Offset(newPosition.dx, newPosition.dy + 0.01);
        break;
    }
    tails.insert(0, newPosition);
    if (tails.length > gameState.counts) {
      tails = tails.sublist(0, gameState.counts);
    }
  }

  void update() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
            children: List.generate(tails.length, (index) {
          var stepPerSize = size / tails.length;
          return Container(
            alignment: Alignment(tails[index].dx, tails[index].dy),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.purple,
              ),
              width: size - (stepPerSize * index),
              height: size - (stepPerSize * index),
            ),
          );
        }));
      },
    );
  }
}
