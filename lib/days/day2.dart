import '../services/input_service.dart';

Future<String> solvePuzzle1() async {
  final lines = await const InputService().readInputLines(2);
  final ranges = lines.first.split(',').map(_parseRange).toList(growable: false);
  int result = 0;

  for (final r in ranges) {
      for (int i = r.min; i <= r.max; i++) {
        if (i.toString().length.isOdd) continue;
        final txt = i.toString();
        final mid = txt.length ~/ 2;
        if (txt.substring(0, mid) == txt.substring(mid)) {
          result += int.parse(txt);
        }
      }
  }
  return 'Value: $result';
}

Future<String> solvePuzzle2() async {
  return 'Ca arrive !';
}

class Range{
  final int min;
  final int max;

  const Range({
    required this.min,
    required this.max,
  });
}

Range _parseRange(String input) {
  return Range(
      min: int.parse(input.split('-')[0]),
      max: int.parse(input.split('-')[1]),
  );
}