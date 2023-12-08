import 'dart:async';

import 'package:flutter/material.dart';
import 'package:snake_game/src/character/apple.dart';
import 'package:snake_game/src/character/player.dart';
import 'package:snake_game/src/model/game_state.dart';
import 'package:snake_game/src/utils/data_util.dart';

class PlayBoard extends StatefulWidget {
  final double size;
  final StreamController gameController;
  const PlayBoard({
    super.key,
    required this.gameController,
    required this.size,
  });

  @override
  State<PlayBoard> createState() => _PlayBoardState();
}

class _PlayBoardState extends State<PlayBoard> {
  late GameState gameState;
  List<Offset> tails = [];
  late Apple apple;
  Direction direction = Direction.right;

  @override
  void initState() {
    super.initState();
    tails = [Offset.zero];
    _makeApple();
    widget.gameController.stream.listen((event) {
      gameState = event as GameState;
      if (gameState.status == GameStatus.run) {
        _moveCharactor();
        _checkCollision();
        update();
      }
    });
  }

  void _makeApple() {
    apple = Apple(
      size: widget.size,
      exeptPosition: tails,
    );
  }

  void _checkCollision() {
    _gameLineCollision(tails.first);
    _appleCollision(tails.first);
  }

  void _appleCollision(Offset position) {
    if (apple.position != null) {
      if (DataUtils.isCrash(apple.position!, position)) {
        _makeApple();
        widget.gameController.sink
            .add(gameState.copyWith(counts: gameState.counts + 1));
      }
    }
  }

  void _gameLineCollision(Offset position) {
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
    direction = gameState.keyboradDirection;
    switch (direction) {
      case Direction.left:
        newPosition = Offset(newPosition.dx - 0.1, newPosition.dy);
        break;
      case Direction.right:
        newPosition = Offset(newPosition.dx + 0.1, newPosition.dy);
        break;
      case Direction.up:
        newPosition = Offset(newPosition.dx, newPosition.dy - 0.1);
        break;
      case Direction.down:
        newPosition = Offset(newPosition.dx, newPosition.dy + 0.1);
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
          children: [
            Player(
              tails: tails,
              size: widget.size,
              direction: direction,
            ),
            apple,
          ],
        );
      },
    );
  }
}
