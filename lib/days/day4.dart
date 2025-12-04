import '../services/input_service.dart';

Future<String> solvePuzzle1() async {
  final lines = await const InputService().readInputLines(4);
  final int height = lines.length;
  final int width = lines[0].length;
  final matrix = parseGrid(lines);
  int result = 0;

  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      if (matrix[y][x] != '@') continue;
      if (_isAccessible(matrix, x , y)) result++;
    }
  }

  return 'IZI! $result';
}

Future<String> solvePuzzle2() async {
  final lines = await const InputService().readInputLines(4);
  final matrix = parseGrid(lines);

  while(iterateDelete(matrix) > 0) {
    print("on refait un tour");
  }
  int before = lines
      .map((line) => '@'.allMatches(line).length)
      .fold(0, (sum, c) => sum + c);
  int after = matrix
      .expand((row) => row)
      .where((cell) => cell == '@')
      .length;

  return 'IZI! ${before - after}';
}

int iterateDelete(List<List<String>> matrix) {
  int deletions = 0;
  final int height = matrix.length;
  final int width = matrix[0].length;
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      if (matrix[y][x] != '@') continue;
      if (_isAccessible(matrix, x , y)) {
        matrix[y][x] = '.';
        deletions++;
      }
    }
  }
  return deletions;
}

bool _isAccessible(List<List<String>> matrix, int x, int y) {
  int count = 0;
  final height = matrix.length;
  final width = matrix[0].length;
  final directions = [
    [-1, -1], //haut gauche
    [ 0, -1], //haut
    [ 1, -1], //haut droite
    [ 1,  0], //droite
    [ 1,  1], //bas droite
    [ 0,  1], //bas
    [-1,  1], //bas gauche
    [-1,  0], //gauche
  ];
  for (final direction in directions) {
    final newX = x + direction[0];
    final newY = y + direction[1];
    if (newX < 0 || newX >= width || newY < 0 || newY >= height) {
      continue;
    } else if (matrix[newY][newX] == '@') {
      count++;
    }
  }
  return count < 4;
}

Future<List<List<int>>> displayPuzzle2() async {
  final lines = await const InputService().readInputLines(4);
  final matrix = parseGrid(lines);
  return evaluatedMatrix(matrix);
}

List<List<String>> parseGrid(List<String> lines) {
  return lines.map((line) => line.split('')).toList();
}



List<List<int>> evaluatedMatrix(List<List<String>> matrix) {
  final int height = matrix.length;
  final int width = matrix[0].length;
  List<List<int>> evalMatrix = List.generate(height, (_) => List.filled(width, 0));
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      if (matrix[y][x] != '@') {
        evalMatrix[y][x] = -1;
      } else {
        evalMatrix[y][x] = _neighbours(matrix, x, y);
      }
    }
  }
  return evalMatrix;
}

int _neighbours(List<List<String>> matrix, int x, int y) {
  int count = 0;
  final height = matrix.length;
  final width = matrix[0].length;
  final directions = [
    [-1, -1], //haut gauche
    [ 0, -1], //haut
    [ 1, -1], //haut droite
    [ 1,  0], //droite
    [ 1,  1], //bas droite
    [ 0,  1], //bas
    [-1,  1], //bas gauche
    [-1,  0], //gauche
  ];
  for (final direction in directions) {
    final newX = x + direction[0];
    final newY = y + direction[1];
    if (newX < 0 || newX >= width || newY < 0 || newY >= height) {
      continue;
    } else if (matrix[newY][newX] == '@') {
      count++;
    }
  }
  return count;
}