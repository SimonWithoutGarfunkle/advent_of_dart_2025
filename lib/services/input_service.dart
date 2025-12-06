import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

/// Service to read Advent of Code input files from bundled assets.
///
/// Files are expected at `web/assets/day{N}.txt` where N is 1..12.
class InputService {
  const InputService();

  /// Reads the lines of the input file for the specified [day] (1..12).
  /// Returns a list of strings, one per non-empty line, preserving order.
  Future<List<String>> readInputLines(int day) async {
    if (day < 1 || day > 12) {
      throw ArgumentError('day must be between 1 and 12 (got $day)');
    }
    final path = 'web/assets/day$day.txt';
    try {
      final content = await rootBundle.loadString(path);
      final normalized = content.replaceAll('\r\n', '\n').replaceAll('\r', '\n');
      return const LineSplitter().convert(normalized);
    } catch (e) {
      throw Exception('Failed to load "$path": $e');
    }
  }
}
