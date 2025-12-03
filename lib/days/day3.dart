import '../services/input_service.dart';
import 'dart:math';

Future<String> solvePuzzle1() async {
  int result = 0;
  final lines = await const InputService().readInputLines(3);
  for (final line in lines) {
    final batteries = _parseBatteries(line);
    result += _getMaxPower(batteries);
  }
  return 'Tada ! $result';
}

Future<String> solvePuzzle2() async {
  int result = 0;
  final lines = await const InputService().readInputLines(3);
  for (final line in lines) {
    final batteries = _parseBatteries(line);
    result += _getMaxPower12(batteries);
  }
  return 'Tada ! $result';
}

List<int> _parseBatteries(String line) {
  return line.split('')
      .map(int.parse)
      .toList();
}

int _getMaxPower(List<int> batteries) {
  final ten = batteries.sublist(0, batteries.length - 1).reduce(max);
  final tenIndex = batteries.indexOf(ten);
  final unit = batteries.sublist(tenIndex + 1).reduce(max);
  return ten * 10 + unit;
}

int _getMaxPower12(List<int> batteries) {
  const k = 12;
  int result = 0;
  var startIndex = 0;

  for (int remaining = k; remaining > 0; remaining--) {
    final end = batteries.length - remaining + 1;
    final slice = batteries.sublist(startIndex, end);
    final chosen = slice.reduce(max);
    final chosenIndex = batteries.indexOf(chosen, startIndex);
    result = result * 10 + chosen;
    startIndex = chosenIndex + 1;
  }

  return result;
}