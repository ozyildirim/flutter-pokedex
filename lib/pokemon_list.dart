import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedex/model/pokedex.dart';
import 'package:pokedex/pokemon_detail.dart';

import 'model/pokedex.dart';

class PokemonList extends StatefulWidget {
  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  String url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  Pokedex pokedex;
  Future<Pokedex> veri;

  Future<Pokedex> pokemonlariGetir() async {
    var response = await http.get(url);
    var decodedJson = jsonDecode(response.body);
    pokedex = Pokedex.fromJson(decodedJson);
    return pokedex;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    veri = pokemonlariGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text("Pokedex"),
      ),
      body: Container(
        child: FutureBuilder(
            future: veri,
            // ignore: missing_return
            builder: (context, AsyncSnapshot<Pokedex> gelenPokedex) {
              if (gelenPokedex.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (gelenPokedex.connectionState == ConnectionState.done) {
                // return GridView.builder(
                //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //         crossAxisCount: 2),
                //     itemBuilder: (context, index) {
                //       return Text(
                //           gelenPokedex.data.pokemon[index].name.toString());
                //     });
                return GridView.count(
                  crossAxisCount: 2,
                  children: gelenPokedex.data.pokemon.map((poke) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PokemonDetail(
                                      pokemon: poke,
                                    )));
                      },
                      child: Hero(
                        tag: poke.img,
                        child: Card(
                          color: Colors.tealAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                child: FadeInImage.assetNetwork(
                                    placeholder: "assets/loading.gif",
                                    image: poke.img),
                              ),
                              Text(
                                poke.name,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }
            }),
      ),
    );
  }
}
