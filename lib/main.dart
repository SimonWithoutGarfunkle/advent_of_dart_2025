import 'package:advent_of_dart_2025/widgets/day4_viewer.dart';
import 'package:flutter/material.dart';
import 'home.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const Day4Page(),
    );
  }
}
