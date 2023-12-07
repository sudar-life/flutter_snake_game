import 'dart:math' as math;
import 'dart:ui';

class DataUtils {
  static double generateRandomNumber() {
    var random = math.Random();
    int randomNumber = random.nextInt(21);
    return randomNumber * 0.1 - 1;
  }

  static bool isCrash(Offset p, Offset t) {
    var distance =
        math.sqrt(math.pow(p.dx - t.dx, 2) + math.pow(p.dy - t.dy, 2));
    return distance < 0.01;
  }

  static double _truncateToOneDecimal(double value) {
    return (value * 10).truncateToDouble() / 10;
  }
}
