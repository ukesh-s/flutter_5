import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:experiment_5/main.dart';

void main() {
  testWidgets('calculates and displays budget status', (tester) async {
    await tester.pumpWidget(const BudgetApp());
    expect(find.text('Personal Budget'), findsOneWidget);
    await tester.enterText(find.widgetWithText(TextField, 'Monthly income'), '4000');
    await tester.enterText(find.widgetWithText(TextField, 'Monthly expenses'), '2750');
    await tester.tap(find.text('Calculate balance'));
    await tester.pumpAndSettle();
    expect(find.text('Remaining balance: \$1250.00'), findsOneWidget);
    expect(find.text('You are within budget'), findsOneWidget);
  });
}
