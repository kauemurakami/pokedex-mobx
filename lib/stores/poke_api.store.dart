import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:pokedex_mobx/consts/consts_api.dart';
import 'package:pokedex_mobx/models/pokeapi.dart';
import 'package:http/http.dart' as http;
part 'poke_api.store.g.dart';


class PokeApiStore = _PokeApiStoreBase with _$PokeApiStore;

abstract class _PokeApiStoreBase with Store {
  
  @observable
  PokeAPI pokeAPI;

  @action
  fetchPokemonList(){
    pokeAPI = null;
    loadPokeAPI().then((pokeList){
      pokeAPI = pokeList;
    });
  }

  Future<PokeAPI> loadPokeAPI() async{
    try{
      final response = await http.get(ConstsAPI.pokeapiUrl);
      var decodeJson = jsonDecode(response.body);
      return PokeAPI.fromJson(decodeJson);
    }catch(e){
      print('Erro ao carregar lista');
      return null;
    }
  }

}