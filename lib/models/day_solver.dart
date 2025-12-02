class DaySolver {
  final int day;
  final Future<String> Function() solve1;
  final Future<String> Function() solve2;

  const DaySolver({
    required this.day,
    required this.solve1,
    required this.solve2,
  });
}