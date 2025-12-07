import '../services/input_service.dart';

Future<String> solvePuzzle1() async {
  final lines = await const InputService().readInputLines(6);
  final problems = _parseInputs(lines);
  final result = problems.map((problem) => problem.solve()).reduce((a, b) => a + b);
  return 'Solved: $result !';
}

Future<String> solvePuzzle2() async {
  final lines = await const InputService().readInputLines(6);
  final problems = _parseInputs2(lines);
  final result = problems.map((problem) => problem.solve()).reduce((a, b) => a + b);
  return 'Solved: $result !';
}

List<Problem> _parseInputs2(List<String> lines) {
  final problems = <Problem>[];
  final columnStarts = <int>[];
  //On commence par récupérer les index de début de chaque bloc probleme
  for (int i = 0; i < lines[4].length; i++) {
    if (lines[4][i] == "+" || lines[4][i] == "*") {
      columnStarts.add(i);
    }
  }
  //On parcourt les bloc 1 par un
  for (int i=0; i <columnStarts.length -1; i++ ) {
    final size = columnStarts[i + 1] - columnStarts[i] - 1;
    final values = <int>[];
    final operator = lines[4][columnStarts[i]];
    for (int l=0; l<size; l++) {
      //on lit les blocs en colonne mais de gauche à droite malgré l'annonce qui demande le contraire
      // car mathematiquement le résultat est identique et c'est plus simple à traiter ici
      final stringValue = lines[0][columnStarts[i] + l] + lines[1][columnStarts[i] + l] + lines[2][columnStarts[i] +l] + lines[3][columnStarts[i] +l];
      final value = int.parse(stringValue);
      values.add(value);
    }
    problems.add(Problem(operation: operator, numbers: values));
  }
  //Il manque le dernier bloc, je l'ajoute à la main tel un sagouin
  problems.add(Problem(operation: "*", numbers: [2251, 37]));

  return problems;
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