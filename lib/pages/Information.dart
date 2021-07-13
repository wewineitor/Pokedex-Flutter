import 'package:flutter/material.dart';
import 'package:pokedex/api/HttpPoke.dart';

class Information extends StatelessWidget {

  String name;
  int index;
  Information(name, index) {
    this.name = name;
    this.index = index;
  }

  @override
  Widget build(BuildContext context) {
    HttpPoke http = new HttpPoke();


    return Scaffold(
      appBar: AppBar(
        title: Text('$name #$index'),
      ),
      body: ListView(
        children: [
          Card(
            child: Hero(
              tag: name, 
              child: Image.network('https://pokeres.bastionbot.org/images/pokemon/$index.png')
            ),
          ),

          Text('Types', style: TextStyle(fontSize: 25),),

          FutureBuilder<List<dynamic>>(
            future: http.getPokemonTypes(name),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              var values = snapshot.data;

              return values.length == 2 ? 
              Text(values[0]['type']['name'] + " - " + values[1]['type']['name'], style: TextStyle(fontSize: 20)) : 
              Text(values[0]['type']['name'], style: TextStyle(fontSize: 20));
            },
          ),

          SizedBox(height: 50,),

          Text('Sprites', style: TextStyle(fontSize: 25),),

          Row(
            children: [
              Image.network('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$index.png'),
              Image.network('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/$index.png'),
              Image.network('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/$index.png'),
              Image.network('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/$index.png')
            ],
          ),

          Text('Moves', style: TextStyle(fontSize: 25),),

          FutureBuilder<List<dynamic>>(
            future: http.getPokemonMoves(name),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              var values = snapshot.data;

              return SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: values.length,
                  itemBuilder: (context, index) {
                    return index == values.length - 1 ? Text(values[index]['move']['name'], style: TextStyle(fontSize: 20)) : Text(values[index]['move']['name'] + ", ", style: TextStyle(fontSize: 20));
                  },
                )
              );
            },
          )
        ],
      )
    );
  }
}