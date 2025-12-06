import '../services/input_service.dart';

Future<String> solvePuzzle1() async {
  final lines = await const InputService().readInputLines(6);
  final problems = _parseInputs(lines);
  final result = problems.map((problem) => problem.solve()).reduce((a, b) => a + b);
  return 'Solved: $result !';
}

Future<String> solvePuzzle2() async {
  return 'Ca arrive !';
}

List<Problem> _parseInputs(List<String> lines) {
  final problems = <Problem>[];
  final values1 = lines[0].trim().split(' ').where((item) => item.isNotEmpty).map((item) => int.parse(item)).toList();
  final values2 = lines[1].trim().split(' ').where((item) => item.isNotEmpty).map((item) => int.parse(item)).toList();
  final value3 = lines[2].trim().split(' ').where((item) => item.isNotEmpty).map((item) => int.parse(item)).toList();
  final values4 = lines[3].trim().split(' ').where((item) => item.isNotEmpty).map((item) => int.parse(item)).toList();
  final operators = lines.last.trim().split(' ').where((item) => item.isNotEmpty).toList();
  for (var i = 0; i < operators.length; i++) {
    problems.add(Problem(operation: operators[i], numbers: List.of([
      values1[i],
      values2[i],
      value3[i],
      values4[i],
    ])));
  }
  return problems;
}

class Problem{
  final String operation;
  final List<int> numbers;
  const Problem({required this.operation, required this.numbers});

  int solve() {
    return numbers.skip(1).fold<int>(
      numbers.first,
          (currentResult, nextNumber) {
        switch (operation) {
          case '+':
            return currentResult + nextNumber;
          case '*':
            return currentResult * nextNumber;
          default:
            throw ArgumentError('Opération non supportée : $operation');
        }
      },
    );
  }
}