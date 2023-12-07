import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  final List<Offset> tails;
  final double size;
  const Player({super.key, required this.size, required this.tails});

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: List.generate(tails.length, (index) {
      var stepPerSize = size / tails.length;
      return AnimatedContainer(
        alignment: Alignment(tails[index].dx, tails[index].dy),
        duration: const Duration(milliseconds: 100),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xff4775eb),
          ),
          width: size - (stepPerSize * index),
          height: size - (stepPerSize * index),
        ),
      );
    }));
  }
}
