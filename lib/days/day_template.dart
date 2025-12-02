import '../services/input_service.dart';

Future<String> solvePuzzle1() async {
  final lines = await const InputService().readInputLines(1);
  final total = lines.fold<int>(0, (sum, line) => sum + line.length);
  return total.toString();
}

Future<String> solvePuzzle2() async {
  return 'vide pour le moment :D';
}