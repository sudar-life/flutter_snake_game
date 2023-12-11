import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snake_game/src/components/app_font.dart';

class GameOverView extends StatelessWidget {
  final int counts;
  const GameOverView(this.counts, {super.key});

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (value) {
        if (value.isKeyPressed(LogicalKeyboardKey.space)) {
          Navigator.of(context).pop();
        }
      },
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xff1d151c),
                ),
                width: 250,
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/game_over.png',
                      width: 200,
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/apple.png',
                          width: 40,
                        ),
                        AppFont(
                          counts.toString(),
                          color: Colors.white,
                          size: 25,
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xffe24c4f),
                  ),
                  child: const AppFont(
                    '다시하기',
                    color: Colors.white,
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
