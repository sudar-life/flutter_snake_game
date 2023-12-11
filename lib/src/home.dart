import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snake_game/src/model/game_state.dart';
import 'package:snake_game/src/ui/background.dart';
import 'package:snake_game/src/ui/game_over_view.dart';
import 'package:snake_game/src/ui/pause_view.dart';
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
  var showKeysetBoard = true;

  @override
  void initState() {
    super.initState();
    _gameSet();
    gameStreamCotnroller.stream.listen((event) {
      gameState = event;
    });
  }

  void _gameSet() {
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (gameState.status == GameStatus.run) {
        gameStreamCotnroller.sink.add(gameState);
      }
      if (gameState.status == GameStatus.gameOver) {
        _gameOverView();
        timer.cancel();
      }
    });
  }

  void reStartGame() {
    gameState = const GameState(status: GameStatus.idle);
    gameStreamCotnroller.sink.add(gameState);
    showKeysetBoard = false;
    _gameSet();
  }

  void startGame() {
    gameState = gameState.copyWith(status: GameStatus.run);
    showKeysetBoard = false;
    update();
  }

  void pauseGame() {
    gameState = gameState.copyWith(status: GameStatus.pause);
    _showPausePopup();
  }

  Future<void> _showPopup(Widget widget) async {
    await Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: widget,
            ),
          );
        },
      ),
    );
  }

  void _gameOverView() async {
    await _showPopup(GameOverView(gameState.counts));
    reStartGame();
  }

  void _showPausePopup() async {
    await _showPopup(const PauseView());
    startGame();
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
        if (value.isKeyPressed(LogicalKeyboardKey.space)) {
          if (gameState.status != GameStatus.run) {
            startGame();
          } else {
            pauseGame();
          }
        }
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
      child: Scaffold(
        backgroundColor: const Color(0xff012f37),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/game_logo.png', width: 140),
                const SizedBox(height: 30),
                ScoreView(gameController: gameStreamCotnroller),
                const SizedBox(height: 10),
                Center(
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 45, 66, 32)
                            .withOpacity(0.7),
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
                            gameController: gameStreamCotnroller,
                            size: 600 / 21),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            showKeysetBoard
                ? Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(40),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black.withOpacity(0.5),
                          ),
                          child: Image.asset(
                            'assets/images/keyboard_set.png',
                            width: 350,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
