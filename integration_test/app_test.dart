import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter_app/main.dart' as app;

void main() {
  group('App Test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('Full app test', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final cartaPokemon = find.byType(InkWell).first;

      await tester.tap(cartaPokemon);
      await tester.pumpAndSettle();

      final nombrePokemon = find.byType(Text).first;
      expect(tester.getSemantics(nombrePokemon),
          matchesSemantics(value: "Bulbasaur"));
    });
  });
}
