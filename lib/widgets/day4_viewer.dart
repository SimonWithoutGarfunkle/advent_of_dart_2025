import 'package:flutter/material.dart';

import '../days/day4.dart';
import 'matrix_viewer.dart';

class Day4Page extends StatefulWidget {
  const Day4Page({super.key});

  @override
  State<Day4Page> createState() => _Day4PageState();
}

class _Day4PageState extends State<Day4Page> {
  // Matrice de référence, jamais modifiée
  final List<List<String>> _initialMatrix = [
    ['.', '@', '.', '.', '@', '.'],
    ['@', '@', '.', '@', '@', '.'],
    ['.', '.', '@', '@', '@', '.'],
    ['.', '@', '@', '@', '@', '.'],
    ['.', '.', '.', '.', '.', '.'],
    ['.', '@', '.', '.', '@', '.'],
  ];

  late List<List<String>> _matrix; // matrice courante

  int _step = 0;
  int _deletedTotal = 0;
  bool _isAuto = false;

  @override
  void initState() {
    super.initState();
    _resetState();
  }

  // Clone profond de la matrice
  List<List<String>> _cloneMatrix(List<List<String>> src) {
    return src.map((row) => List<String>.from(row)).toList();
  }

  void _resetState() {
    _matrix = _cloneMatrix(_initialMatrix);
    _step = 0;
    _deletedTotal = 0;
    _isAuto = false;
  }

  void _stepOnce() {
    final deleted = iterateDelete(_matrix);
    if (deleted == 0) {
      return;
    }

    setState(() {
      _step++;
      _deletedTotal += deleted;
    });
  }

  Future<void> _runAuto() async {
    if (_isAuto) return;

    setState(() {
      _isAuto = true;
    });

    while (true) {
      final deleted = iterateDelete(_matrix);
      if (deleted == 0) break;

      setState(() {
        _step++;
        _deletedTotal += deleted;
      });

      await Future.delayed(const Duration(milliseconds: 200));
    }

    setState(() {
      _isAuto = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final evalMatrix = evaluatedMatrix(_matrix);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Puzzle 2 – visualisation'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Text('Étapes : $_step   |   supprimés : $_deletedTotal'),
          const SizedBox(height: 8),
          IntMatrixView(matrix: evalMatrix, cellSize: 24),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _stepOnce,
                child: const Text('Step +1'),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: _isAuto ? null : _runAuto,
                child: const Text('Auto'),
              ),
              const SizedBox(width: 12),
              TextButton(
                onPressed: () {
                  setState(_resetState);
                },
                child: const Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
