import 'dart:async';

import 'package:flutter/material.dart';
import 'package:snake_game/src/model/game_state.dart';

class ScoreView extends StatefulWidget {
  final StreamController gameController;
  const ScoreView({super.key, required this.gameController});

  @override
  State<ScoreView> createState() => _ScoreViewState();
}

class _ScoreViewState extends State<ScoreView> {
  int level = 1;
  @override
  void initState() {
    super.initState();
    widget.gameController.stream.listen((event) {
      var gameState = event as GameState;
      if (gameState.status == GameStatus.run) {
        level = gameState.counts;
        update();
      }
    });
  }

  void update() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Text(
      '${level}Level',
      style: const TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
    );
  }
}
