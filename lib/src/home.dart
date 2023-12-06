import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snake_game/src/character/player.dart';
import 'package:snake_game/src/model/game_state.dart';
import 'package:snake_game/src/ui/background.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamController<GameState> gameStreamCotnroller =
      StreamController<GameState>.broadcast();
  var gameState = const GameState();

  void startGame() {
    gameState = gameState.copyWith(status: GameStatus.run);
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (gameState.status == GameStatus.run) {
        gameStreamCotnroller.sink.add(gameState);
      }
      if (gameState.status == GameStatus.gameOver) {
        timer.cancel();
      }
    });
    update();
  }

  @override
  void initState() {
    super.initState();
    gameStreamCotnroller.stream.listen((event) {
      if (event.status == GameStatus.gameOver) {
        gameState = event;
        update();
      }
    });
  }

  @override
  void dispose() {
    gameStreamCotnroller.close();
    super.dispose();
  }

  void update() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (value) {
        if (gameState.status != GameStatus.run) return;
        if (value.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          gameState = gameState.copyWith(keyboradDirection: Direction.left);
        }
        if (value.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          gameState = gameState.copyWith(keyboradDirection: Direction.right);
        }
        if (value.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
          gameState = gameState.copyWith(keyboradDirection: Direction.up);
        }
        if (value.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
          gameState = gameState.copyWith(keyboradDirection: Direction.down);
        }
        update();
      },
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
          body: Center(
            child: SizedBox(
              width: 600,
              height: 600,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  const Background(tileSize: (sizeX: 15, sizeY: 15)),
                  Player(gameController: gameStreamCotnroller),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
