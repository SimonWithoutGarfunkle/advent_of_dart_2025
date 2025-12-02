import 'package:flutter/material.dart';
import '../services/input_service.dart';

class DayCheck extends StatelessWidget {
  const DayCheck({super.key});

  final day = 1;

  Future<List<String>> _load() => const InputService().readInputLines(day);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Day $day'),
      ),
      body: FutureBuilder<List<String>>(
        future: _load(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Erreur de chargement: ${snapshot.error}',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          final lines = snapshot.data ?? const <String>[];
          if (lines.isEmpty) {
            return Center(child: Text('Aucune donnée dans day$day.txt'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: lines.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              return ListTile(
                dense: true,
                leading: Text('${index + 1}'),
                title: Text(lines[index]),
              );
            },
          );
        },
      ),
    );
  }
}
