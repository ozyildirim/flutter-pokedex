import 'package:flutter/material.dart';
import 'package:pokedex/model/pokedex.dart';

class PokemonDetail extends StatelessWidget {
  Pokemon pokemon;
  PokemonDetail({this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          pokemon.name,
          textAlign: TextAlign.center,
        ),
        elevation: 0,
      ),
      body: Stack(children: [
        Positioned(
          height: MediaQuery.of(context).size.height * (2 / 3),
          width: MediaQuery.of(context).size.width - 20,
          left: 10,
          top: MediaQuery.of(context).size.height * 0.1,
          child: Card(
            elevation: 6,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Text(pokemon.name),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
            tag: pokemon.img,
            child: Container(
              height: 200,
              width: 200,
              child: Image.network(
                pokemon.img,
                fit: BoxFit.contain,
                scale: 1,
              ),
            ),
          ),
        )
      ]),
    );
  }
}
