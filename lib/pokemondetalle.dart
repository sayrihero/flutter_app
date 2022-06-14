import 'package:flutter/material.dart';
import 'package:flutter_app/pokemon.dart';

class PokeDetalle extends StatelessWidget {
  Pokemon? pokemon;

  PokeDetalle({this.pokemon});

  bodyWidget(BuildContext context) => Stack(
        children: <Widget>[
          Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 40,
            top: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.height * 0.03,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  const SizedBox(
                    height: 70.0,
                  ),
                  Text(
                    pokemon!.name!,
                    style: const TextStyle(
                        fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  Text("Altura: ${pokemon!.height!}"),
                  Text("Peso: ${pokemon!.weight!}"),
                  const Text(
                    "Tipos",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon!.type!
                        .map((t) => FilterChip(
                            backgroundColor: Colors.amber,
                            label: Text(t),
                            onSelected: (b) {}))
                        .toList(),
                  ),
                  const Text("Debilidades",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon!.weaknesses!
                        .map((w) => FilterChip(
                            backgroundColor: Colors.red,
                            label: Text(
                              w,
                              style: const TextStyle(color: Colors.white),
                            ),
                            onSelected: (b) {}))
                        .toList(),
                  ),
                  const Text("Evolución Previa",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon!.prevEvolution == null
                        ? <Widget>[const Text("No tiene evoluciones previas.")]
                        : pokemon!.prevEvolution!
                            .map((p) => FilterChip(
                                  backgroundColor: Colors.blueGrey,
                                  label: Text(
                                    p.name!,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  onSelected: (b) {},
                                ))
                            .toList(),
                  ),
                  const Text("Siguiente Evolución",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon!.nextEvolution == null
                        ? <Widget>[const Text("No tiene más evoluciones.")]
                        : pokemon!.nextEvolution!
                            .map((n) => FilterChip(
                                  backgroundColor: Colors.green,
                                  label: Text(
                                    n.name!,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  onSelected: (b) {},
                                ))
                            .toList(),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
                tag: pokemon!.id!,
                child: Column(
                  children: [
                    Container(
                      height: 195.0,
                      width: 195.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.network(pokemon!.img!).image)),
                    )
                  ],
                )),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(pokemon!.name!),
      ),
      body: bodyWidget(context),
    );
  }
}
