import 'package:flutter/material.dart';
import '../services/input_service.dart';

class Day1 extends StatelessWidget {
  const Day1({super.key});

  Future<List<String>> _load() => const InputService().readInputLines(1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Day 1'),
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
            return const Center(child: Text('Aucune donnée dans day1.txt'));
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
