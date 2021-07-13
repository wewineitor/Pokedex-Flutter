import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpPoke {
  List<dynamic> pokemonList;
  String color;

  Future<List<dynamic>> getPokemon() async {
    final response = await http.get(Uri.https('pokeapi.co', '/api/v2/pokemon', {'limit': '151'}));

    final data = jsonDecode(response.body);

    final data2 = jsonEncode(data['results']);

    final data3 = jsonDecode(data2);

    return data3;
  }

  Future<List<dynamic>> getPokemonMoves(name) async {
    final response = await http.get(Uri.https('pokeapi.co', '/api/v2/pokemon/$name'));

    final data = jsonDecode(response.body);

    final data2 = jsonEncode(data['moves']);

    final data3 = jsonDecode(data2);

    return data3;
  }

  Future<List<dynamic>> getPokemonTypes(name) async {
    final response = await http.get(Uri.https('pokeapi.co', '/api/v2/pokemon/$name'));

    final data = jsonDecode(response.body);

    final data2 = jsonEncode(data['types']);

    final data3 = jsonDecode(data2);

    return data3;
  }
}
