import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/pokemon.dart';

void main() {
  test('El mapeador debe funcionar', () {
    var pokemon = Pokemon(id: 1, num: '001', name: 'Agumon');

    Map<String, dynamic> contPokemon = pokemon.toJson();

    expect(contPokemon, isNotNull);
    expect(contPokemon.values.elementAt(0), 1);
    expect(contPokemon.values.elementAt(1), '001');
    expect(contPokemon.values.elementAt(2), 'Agumon');
  });
}
