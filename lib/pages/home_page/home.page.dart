import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokedex_mobx/consts/consts_app.dart';
import 'package:pokedex_mobx/models/pokeapi.dart';
import 'package:pokedex_mobx/stores/poke_api.store.dart';

import 'widgets/app_bar_home.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PokeApiStore pokeApiStore;

  @override
  void initState() {
    super.initState();
    pokeApiStore = PokeApiStore();
    pokeApiStore.fetchPokemonList();
  }
  @override
  Widget build(BuildContext context) {
    
    double screenWidth = MediaQuery.of(context).size.width;
    double statusWidth = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            top: -(240 / 4.7),
            left: screenWidth - (240 / 1.69),
            child: Opacity(
                opacity: 0.2,
                child: Image.asset(
                  ConstsApp.blackPokeball,
                  height: 240,
                  width: 240,
                )),
          ),
          Container(
              child: Column(
            children: <Widget>[
              Container(
                height: statusWidth,
              ),
              AppBarHome(),
              Expanded(
                child: Container(
                  child: Observer(
                    builder: (_) {
                      PokeAPI _pokeApi = pokeApiStore.pokeAPI;
                      return (pokeApiStore != null) ?  
                      ListView.builder(
                        itemCount: _pokeApi.pokemon.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              _pokeApi.pokemon[index].name,
                            ),
                          );
                        },
                      ): Center(child: CircularProgressIndicator(),);
                    },
                  ),
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}
