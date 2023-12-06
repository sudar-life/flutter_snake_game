import 'package:equatable/equatable.dart';

class GameState extends Equatable {
  final Direction keyboradDirection;
  final GameStatus status;
  final int counts;
  const GameState({
    this.status = GameStatus.idle,
    this.keyboradDirection = Direction.right,
    this.counts = 100,
  });

  @override
  List<Object?> get props => [
        keyboradDirection,
        status,
        counts,
      ];

  GameState copyWith({
    Direction? keyboradDirection,
    GameStatus? status,
    int? counts,
  }) {
    return GameState(
      keyboradDirection: keyboradDirection ?? this.keyboradDirection,
      status: status ?? this.status,
      counts: counts ?? this.counts,
    );
  }
}

enum GameStatus {
  idle,
  run,
  gameOver,
}

enum Direction {
  left,
  right,
  up,
  down,
}
