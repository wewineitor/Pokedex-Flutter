import 'package:flutter/material.dart';
import 'package:pokedex/api/HttpPoke.dart';
import 'package:pokedex/pages/Information.dart';

class Homepage extends StatelessWidget {
  HttpPoke http = new HttpPoke();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
      future: http.getPokemon(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator()
            ),
          );
        }

        var values = snapshot.data;
        
        return GridView.builder(
          
          itemCount: values.length,
          
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2
          ), 
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(values[index]['name']),
                  
                  Text('#${(index + 1)}'),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Information(values[index]['name'], index + 1)));
                    },
                    child: Hero(
                      tag: values[index]['name'],
                      child: Container(
                        margin: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: FadeInImage.assetNetwork(
                          height: 135,
                          placeholder: 'lib/assets/img/loading.gif',
                          image: 'https://pokeres.bastionbot.org/images/pokemon/${index + 1}.png',
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        );
      },
    ));
  }
}