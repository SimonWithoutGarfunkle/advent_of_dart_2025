import '../services/input_service.dart';

Future<String> solvePuzzle1() async {
  return '✅';
  final lines = await const InputService().readInputLines(1);
  final rotations = lines.map(_parseRotation).toList(growable: false);

  const int modulo = 100;
  int current = 50;
  int zeroCount = 0;

  for (final r in rotations) {
    if (r.clockWise) {
      current = (current + r.value) % modulo;
    } else {
      current = (current - r.value) % modulo;
    }
    if (current == 0) zeroCount++;
  }

  return 'Value: $zeroCount';
}

Future<String> solvePuzzle2() async {
  return '✅';
  final lines = await const InputService().readInputLines(1);
  final rotations = lines.map(_parseRotation).toList(growable: false);

  const int modulo = 100;
  int current = 50;
  int zeroCount = 0;

  for (final r in rotations) {
    final step = r.clockWise ? 1 : -1;
    for (int i = 0; i < r.value; i++) {
      current = (current + step) % modulo;
      if (current == 0) {
        zeroCount++;
      }
    }
  }

  return 'Value: $zeroCount';
}

class Rotate {
  final bool clockWise;
  final int value;

  const Rotate({
    required this.clockWise,
    required this.value,
  });
}

Rotate _parseRotation(String line) {
  return Rotate(
      clockWise: line.startsWith("R"),
      value: int.parse(line.substring(1))
  );
}