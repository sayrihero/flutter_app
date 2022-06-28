import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter_app/main.dart' as app;

//https://www.youtube.com/watch?v=WPEsnJgW99M
void main() {
  group('App Test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('Full app test', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final cartaPokemon = find.byType(InkWell).first;

      await tester.tap(cartaPokemon);
      await tester.pumpAndSettle();

      final nombrePokemon = find.byKey(const Key("txtPokemonName"));
      expect(
          tester.getSemantics(nombrePokemon),
          matchesSemantics(
              label:
                  "Bulbasaur\nAltura: 0.71 m\nPeso: 6.9 kg\nTipos\nDebilidades\nEvolución Previa\nNo tiene evoluciones previas.\nSiguiente Evolución"));
    });
  });
}
