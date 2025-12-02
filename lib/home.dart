import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
                          rows: List<DataRow>.generate(12, (index) {
                            final day = 'Jour ${index + 1}';
                            final isEven = index.isEven;
                            return DataRow(
                              color: WidgetStatePropertyAll(
                                isEven
                                    ? const Color(0x10FFEBEE)
                                    : const Color(0x103E2723),
                              ),
                              cells: [
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
                                      Text(day),
                                    ],
                                  ),
                                ),
                                const DataCell(
                                  Center(child: Text('')),
                                ),
                                const DataCell(
                                  Center(child: Text('')),
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
