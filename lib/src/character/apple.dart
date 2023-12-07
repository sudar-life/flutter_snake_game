import 'package:flutter/material.dart';
import 'package:snake_game/src/utils/data_util.dart';

class Apple extends StatelessWidget {
  final List<Offset> exeptPosition;
  final double size;
  Apple({
    super.key,
    required this.exeptPosition,
    required this.size,
  });

  Offset? position;

  Offset makeResponPosition() {
    var newPosition = Offset(
        DataUtils.generateRandomNumber(), DataUtils.generateRandomNumber());
    bool isPossible = true;
    for (var ep in exeptPosition) {
      var isCrash = DataUtils.isCrash(newPosition, ep);
      if (isCrash) {
        isPossible = false;
        break;
      }
    }
    if (!isPossible) {
      return makeResponPosition();
    }
    return newPosition;
  }

  @override
  Widget build(BuildContext context) {
    position = makeResponPosition();
    return Container(
      alignment: Alignment(position!.dx, position!.dy),
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xffe7471d),
        ),
      ),
    );
  }
}
