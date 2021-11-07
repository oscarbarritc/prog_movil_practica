import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practica2/src/models/games_model.dart';
import 'package:practica2/src/network/api_popular.dart';
import 'package:practica2/src/utils/color_settings.dart';
import 'package:practica2/src/views/card_game.dart';

class VideoGamesSearchScreen extends StatefulWidget {
  VideoGamesSearchScreen({Key? key}) : super(key: key);

  @override
  _VideoGameSearchState createState() => _VideoGameSearchState();
}

class _VideoGameSearchState extends State<VideoGamesSearchScreen> {
  ApiPopular? apipopular;
  int pagina = 1;

  Icon customIcon = const Icon(Icons.search);
  List<int> pageitems = [];
  @override
  void initState() {
    super.initState();
    apipopular = ApiPopular();
  }

  @override
  Widget build(BuildContext context) {
    final busqueda = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final lista = <int>[];
    for (int i = 1; i <= busqueda['paginas']; i++) {
      lista.add(i);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsSettings.colorPrimary,
        title: Text('Busqueda de "'+ busqueda['busqueda']+'"'),
      ),
      bottomNavigationBar: Container(
        color: ColorsSettings.colorPrimary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Pagina    '),
            Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.grey[700],
              ),
              child: DropdownButton<int>(
                value: pagina,
                style: const TextStyle(color: Colors.white),
                onChanged: (int? newValue) {
                  setState(() {
                    pagina = newValue!;
                  });
                },
                items: lista.map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: apipopular!.getgamessearch(busqueda['busqueda'],pagina),
        builder:
            (BuildContext context, AsyncSnapshot<List<GamesModel>?> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error en la peticion'),
            );
          } else {
            if (snapshot.connectionState == ConnectionState.done) {
              return _listPopularMovies(snapshot.data);
            } else {
              return CircularProgressIndicator();
            }
          }
        },
      ),
    );
  }

  Widget _listPopularMovies(List<GamesModel>? juegos) {
    return ListView.separated(
        itemBuilder: (context, index) {
          GamesModel popular = juegos![index];

          return CardGameView(games: popular);
        },
        separatorBuilder: (_, __) => Divider(
              height: 10,
            ),
        itemCount: juegos!.length);
  }

 

}
