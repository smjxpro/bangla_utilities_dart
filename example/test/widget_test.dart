import 'package:flutter_test/flutter_test.dart';

import 'package:bangla_utilities_example/main.dart';

void main() {
  testWidgets('Example app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const BanglaUtilitiesExampleApp());

    // The app bar title should always be present.
    expect(find.text('Bangla Utilities Example'), findsOneWidget);
  });
}
