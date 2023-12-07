import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snake_game/src/character/player.dart';
import 'package:snake_game/src/model/game_state.dart';
import 'package:snake_game/src/ui/background.dart';
import 'package:snake_game/src/ui/playboard.dart';
import 'package:snake_game/src/ui/score_view.dart';

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
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
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
      gameState = event;
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
      },
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
          backgroundColor: const Color(0xff578a34),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScoreView(
                gameController: gameStreamCotnroller,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 45, 66, 32).withOpacity(0.7),
                      blurRadius: 8.0,
                      spreadRadius: 0.0,
                      offset: const Offset(0, 7),
                    )
                  ]),
                  width: 600,
                  height: 600,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      const Background(tileSize: (sizeX: 21, sizeY: 21)),
                      PlayBoard(
                          gameController: gameStreamCotnroller, size: 600 / 21),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
