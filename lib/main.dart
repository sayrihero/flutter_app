import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/pokemon.dart';
import 'package:flutter_app/pokemondetalle.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon App CI/CD',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const MyHomePage(
        title: 'Pokemon App',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var url =
      "https://raw.githubusercontent.com/sayrihero/flutter_app/main/pokedex.json";

  int crossAxisCount = 2;

  PokeHub? pokeHub;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    double tamPantalla = MediaQuery.of(context).size.width;
    if (tamPantalla < 350.0) {
      crossAxisCount = 1;
    }
    if (tamPantalla >= 350.0 && tamPantalla <= 520.0) {
      crossAxisCount = 2;
    }
    if (tamPantalla > 520.0 && tamPantalla <= 950.0) {
      crossAxisCount = 3;
    }
    if (tamPantalla > 950.0) {
      crossAxisCount = 4;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: pokeHub == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.count(
              crossAxisCount: crossAxisCount,
              children: pokeHub!.pokemon!
                  .map((poke) => Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PokeDetalle(
                                  pokemon: poke,
                                ),
                              ),
                            );
                          },
                          child: Hero(
                            tag: poke.id!,
                            child: Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: Image.network(poke.img!).image,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    poke.name!,
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
      drawer: const Drawer(),
    );
  }

  void fetchData() async {
    var res = await http.get(Uri.parse(url));
    var decodedJson = jsonDecode(res.body);
    if (res.statusCode == 200) {
      pokeHub = PokeHub.fromJson(decodedJson);
      // ignore: no-empty-block
      setState(() {});
    } else {
      throw Exception('Fallo al cargar los datos');
    }
  }
}
