import 'package:flutter_test/flutter_test.dart';
import 'package:villas_homestays/main.dart';

void main() {
  testWidgets('Home screen shows the search card', (WidgetTester tester) async {
    await tester.pumpWidget(const VillasApp());

    expect(find.text('Villas & Homestays'), findsOneWidget);
    expect(find.text('Search location'), findsOneWidget);
    expect(find.text('Select dates'), findsOneWidget);
    expect(find.text('2 Adults & 0 Children'), findsOneWidget);
    expect(find.text('SEARCH'), findsOneWidget);
  });
}
