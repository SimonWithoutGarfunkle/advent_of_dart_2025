import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:advent_of_dart_2025/main.dart';

void main() {
  testWidgets('App renders a blank page', (tester) async {
    await tester.pumpWidget(const App());
    // The root body is a SizedBox.shrink(), so the tree should contain exactly one SizedBox.
    expect(find.byType(SizedBox), findsOneWidget);
  });
}
