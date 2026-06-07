// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:lab5/main.dart';

void main() {
  testWidgets('shows movie list and opens detail screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MovieApp());
    await tester.pumpAndSettle();

    expect(find.text('Movie Explorer'), findsOneWidget);
    expect(find.text('Dune: Part Two'), findsOneWidget);
    expect(find.text('Spider-Man: Across the Spider-Verse'), findsOneWidget);

    await tester.tap(find.text('Dune: Part Two'));
    await tester.pumpAndSettle();

    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Trailers'), findsOneWidget);
    expect(find.text('Official Trailer 2'), findsOneWidget);
  });
}
