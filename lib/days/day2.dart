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
  final lines = await const InputService().readInputLines(2);
  final ranges = lines.first.split(',').map(_parseRange).toList(growable: false);
  int result = 0;

  for (final r in ranges) {
    for (int i = r.min; i <= r.max; i++) {
      result += _invalid(i);
    }
  }
  return 'Value: $result';
}

class Range{
  final int min;
  final int max;

  const Range({
    required this.min,
    required this.max,
  });
}

int _invalid(int value) {
  final txt = value.toString();
  final length = txt.length;
  if (length == 1 ) return 0;

  for (int i = 1; i <= length ~/ 2; i++) {
    if (length % i != 0) continue;
    final pattern = txt.substring(0, i);
    final repeatCount = length ~/ i;
    final repeated = List.filled(repeatCount, pattern).join();
    if (repeated == txt) return value;
  }
  return 0;
}

Range _parseRange(String input) {
  return Range(
      min: int.parse(input.split('-')[0]),
      max: int.parse(input.split('-')[1]),
  );
}