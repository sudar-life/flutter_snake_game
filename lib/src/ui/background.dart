import 'dart:developer';

import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final ({int sizeX, int sizeY}) tileSize;
  const Background({super.key, required this.tileSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffaad751),
      width: double.infinity,
      height: double.infinity,
      child: CustomPaint(
        painter: BGTilePainter(tileSize: tileSize),
      ),
    );
  }
}

class BGTilePainter extends CustomPainter {
  final ({int sizeX, int sizeY}) tileSize;
  const BGTilePainter({required this.tileSize});

  @override
  void paint(Canvas canvas, Size size) {
    var w = size.width / tileSize.sizeX;
    var paint = Paint()..color = const Color(0xffa2d149);
    var path = Path();
    path.moveTo(0, 0);
    for (int y = 0; y < tileSize.sizeY; y++) {
      for (int x = 0; x < tileSize.sizeX; x++) {
        var isOdd = y % 2 == 0;
        var left = w * x + (isOdd ? w : 0);
        if (x % 2 == 0 && left < size.width) {
          path.addRect(Rect.fromLTWH(left, w * y, w, w));
        }
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
