import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final ({int sizeX, int sizeY}) tileSize;
  const Background({super.key, required this.tileSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
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
    var paint = Paint()..color = const Color.fromARGB(255, 42, 103, 44);
    var path = Path();
    path.moveTo(0, 0);
    for (int y = 0; y < tileSize.sizeY; y++) {
      for (int x = 0; x < tileSize.sizeX; x++) {
        var isOdd = y % 2 == 0;
        var left = 40.0 * x + (isOdd ? 40 : 0);
        if (x % 2 == 0 && left < size.width) {
          path.addRect(Rect.fromLTWH(left, 40.0 * y, 40, 40));
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
