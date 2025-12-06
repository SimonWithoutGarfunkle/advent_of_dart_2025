import '../services/input_service.dart';

Future<String> solvePuzzle1() async {
  final lines = await const InputService().readInputLines(5);
  final ingredients = <int>[];
  final ranges = <Range>[];
  _parseInputs(lines, ingredients, ranges);

  final count = ingredients.where((ingredient) {
    return ranges.any((range) => ingredient >= range.min && ingredient <= range.max);
  }).length;

  return 'Ingredients: $count !';
}

Future<String> solvePuzzle2() async {
  final lines = await const InputService().readInputLines(5);
  final ranges = _parseInputs2(lines);
  final optimizedRanges = optimizeRange(ranges);
  final count = optimizedRanges.map((range) => range.max - range.min + 1).fold<int>(
    0, (previousValue, length) => previousValue + length,
  );
  return 'Valides $count';
}

void _parseInputs(List<String> lines, List<int> ingredients, List<Range> range) {
  bool isRange = true;
  for (final line in lines) {
    if (line.trim().isEmpty) {
      isRange = false;
      continue;
    }
    if (isRange) {
      final parts = line.split('-');
      final min = int.parse(parts[0]);
      final max = int.parse(parts[1]);
      range.add(Range(min: min, max: max) );
    } else {
      ingredients.add(int.parse(line));
    }
  }
}

List<Range> optimizeRange(List<Range> ranges) {
  ranges.sort((a, b) => a.min.compareTo(b.min));
  final optimized = <Range>[];
  for (final range in ranges) {
    if (optimized.isEmpty || optimized.last.max < range.min) {
      optimized.add(range);
    } else {
      optimized.last.max = optimized.last.max > range.max ? optimized.last.max : range.max;
    }
  }
  return optimized;
}

List<Range> _parseInputs2(List<String> lines) {
  final range = <Range>[];
  for (final line in lines) {
    if (line.trim().isEmpty) {
      break;
    }
    final parts = line.split('-');
    final min = int.parse(parts[0]);
    final max = int.parse(parts[1]);
    range.add(Range(min: min, max: max) );
  }
  return range;
}

class Range{
  int min;
  int max;

  Range({
    required this.min,
    required this.max,
  });
}