import 'package:flutter/material.dart';

class IntMatrixView extends StatelessWidget {
  final List<List<int>> matrix;
  final double cellSize;

  const IntMatrixView({
    super.key,
    required this.matrix,
    this.cellSize = 40,
  });

  @override
  Widget build(BuildContext context) {
    if (matrix.isEmpty || matrix.first.isEmpty) {
      return const Text("Matrice vide");
    }

    final rowCount = matrix.length;
    final colCount = matrix.first.length;

    return SizedBox(
      width: colCount * cellSize,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: colCount,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          childAspectRatio: 1,
        ),
        itemCount: rowCount * colCount,
        itemBuilder: (context, index) {
          final row = index ~/ colCount;
          final col = index % colCount;
          final value = matrix[row][col];

          return _MatrixCell(value: value);
        },
      ),
    );
  }
}

class _MatrixCell extends StatelessWidget {
  final int value;

  const _MatrixCell({required this.value});

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = value < 0;

    return Container(
      decoration: BoxDecoration(
        color: isEmpty ? Colors.grey.shade200 : Colors.blue.shade100,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Center(
        child: isEmpty
            ? const SizedBox.shrink()
            : Text(
          value.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

