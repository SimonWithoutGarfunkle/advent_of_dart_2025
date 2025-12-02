import 'package:flutter/material.dart';

import 'models/day_solver.dart';
import 'days/day1.dart' as d1;
import 'days/day2.dart' as d2;
import 'days/day3.dart' as d3;
import 'days/day4.dart' as d4;
import 'days/day5.dart' as d5;
import 'days/day6.dart' as d6;
import 'days/day7.dart' as d7;
import 'days/day8.dart' as d8;
import 'days/day9.dart' as d9;
import 'days/day10.dart' as d10;
import 'days/day11.dart' as d11;
import 'days/day12.dart' as d12;


class Home extends StatelessWidget {
  const Home({super.key});

  static const List<DaySolver> _days = [
    DaySolver(day: 1, solve1: d1.solvePuzzle1, solve2: d1.solvePuzzle2),
    DaySolver(day: 2, solve1: d2.solvePuzzle1, solve2: d2.solvePuzzle2),
    DaySolver(day: 3, solve1: d3.solvePuzzle1, solve2: d3.solvePuzzle2),
    DaySolver(day: 4, solve1: d4.solvePuzzle1, solve2: d4.solvePuzzle2),
    DaySolver(day: 5, solve1: d5.solvePuzzle1, solve2: d5.solvePuzzle2),
    DaySolver(day: 6, solve1: d6.solvePuzzle1, solve2: d6.solvePuzzle2),
    DaySolver(day: 7, solve1: d7.solvePuzzle1, solve2: d7.solvePuzzle2),
    DaySolver(day: 8, solve1: d8.solvePuzzle1, solve2: d8.solvePuzzle2),
    DaySolver(day: 9, solve1: d9.solvePuzzle1, solve2: d9.solvePuzzle2),
    DaySolver(day: 10, solve1: d10.solvePuzzle1, solve2: d10.solvePuzzle2),
    DaySolver(day: 11, solve1: d11.solvePuzzle1, solve2: d11.solvePuzzle2),
    DaySolver(day: 12, solve1: d12.solvePuzzle1, solve2: d12.solvePuzzle2),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF004D40),
              Color(0xFFB71C1C),
              Color(0xFFFFD54F),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '🎄 Advent of Code 2025 🎄',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.4,
                      shadows: const [
                        Shadow(
                          blurRadius: 12,
                          color: Colors.black54,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    children: const [
                      Icon(Icons.ac_unit_rounded, color: Colors.white, size: 20),
                      Icon(Icons.star, color: Colors.amber, size: 22),
                      Icon(Icons.celebration, color: Colors.white, size: 20),
                      Icon(Icons.park_rounded, color: Colors.greenAccent, size: 22),
                    ],
                  ),
                  const SizedBox(height: 16),

                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 720),
                    child: Card(
                      elevation: 10,
                      shadowColor: Colors.black54,
                      color: const Color(0xF2FFFFFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: const BorderSide(
                          color: Color(0x33FFFFFF),
                          width: 1.2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: DataTable(
                          headingRowColor: const WidgetStatePropertyAll(
                            Color(0xFF1B5E20),
                          ),
                          headingTextStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          dataTextStyle: const TextStyle(
                            color: Colors.black87,
                          ),
                          columnSpacing: 32,
                          dividerThickness: 0.6,
                          border: TableBorder(
                            horizontalInside: BorderSide(
                              color: Colors.grey.shade300,
                              width: 0.5,
                            ),
                          ),
                          columns: const [
                            DataColumn(
                              label: Center(child: Text('Jour')),
                            ),
                            DataColumn(
                              label: Center(child: Text('Solution 1')),
                            ),
                            DataColumn(
                              label: Center(child: Text('Solution 2')),
                            ),
                          ],
                          rows: List<DataRow>.generate(_days.length, (index) {
                            final daySolver = _days[index];
                            final isEven = index.isEven;
                            final dayLabel = 'Jour ${daySolver.day}';

                            return DataRow(
                              color: WidgetStatePropertyAll(
                                isEven
                                    ? const Color(0x10FFEBEE)
                                    : const Color(0x103E2723),
                              ),
                              cells: [
                                // Colonne 1 : jour
                                DataCell(
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.calendar_today_rounded,
                                        size: 16,
                                        color: Color(0xFFB71C1C),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(dayLabel),
                                    ],
                                  ),
                                ),

                                // Colonne 2 : question 1
                                DataCell(
                                  Center(
                                    child: FutureBuilder<String>(
                                      future: daySolver.solve1(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const SizedBox(
                                            width: 18,
                                            height: 18,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          );
                                        }
                                        if (snapshot.hasError) {
                                          return const Icon(
                                            Icons.error,
                                            color: Colors.red,
                                            size: 18,
                                          );
                                        }
                                        final text = snapshot.data ?? '';
                                        return SelectableText(
                                          text,
                                          textAlign: TextAlign.center,
                                        );
                                      },
                                    ),
                                  ),
                                ),

                                // Colonne 3 : question 2
                                DataCell(
                                  Center(
                                    child: FutureBuilder<String>(
                                      future: daySolver.solve2(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const SizedBox(
                                            width: 18,
                                            height: 18,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          );
                                        }
                                        if (snapshot.hasError) {
                                          return const Icon(
                                            Icons.error,
                                            color: Colors.red,
                                            size: 18,
                                          );
                                        }
                                        final text = snapshot.data ?? '';
                                        return SelectableText(
                                          text,
                                          textAlign: TextAlign.center,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  Text(
                    'Prépare ton chocolat chaud et résous le puzzle du jour ✨',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
