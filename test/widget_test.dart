import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ideas2invest_mobile/screens/about_screen.dart';
import 'package:ideas2invest_mobile/screens/settings_screen.dart';

void main() {
  group('AboutScreen', () {
    testWidgets('renders app title and version', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: AboutScreen()),
      );

      expect(find.text('Ideas2invest'), findsOneWidget);
      expect(find.text('Version 1.0.0'), findsOneWidget);
    });
  });

  group('SettingsScreen', () {
    testWidgets('renders settings tiles', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SettingsScreen()),
      );

      expect(find.text('Dark Mode'), findsOneWidget);
      expect(find.text('Clear Cache'), findsOneWidget);
      expect(find.text('Version'), findsOneWidget);
    });
  });
}
