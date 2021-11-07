import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practica2/src/models/games_model.dart';
import 'package:practica2/src/network/api_popular.dart';
import 'package:practica2/src/utils/color_settings.dart';
import 'package:practica2/src/views/card_game.dart';

class VideoGamesScreen extends StatefulWidget {
  VideoGamesScreen({Key? key}) : super(key: key);

  @override
  _VideoGameState createState() => _VideoGameState();
}

class _VideoGameState extends State<VideoGamesScreen> {
  ApiPopular? apipopular;
  int pagina = 1;

  Icon customIcon = const Icon(Icons.search);
  List<int> pageitems = [];
  Widget customSearchBar = const Text('My Personal Journal');

  @override
  void initState() {
    super.initState();
    apipopular = ApiPopular();
  }

  @override
  Widget build(BuildContext context) {
    String busqueda = '';
    final lista = <int>[];
    for (int i = 1; i <= 100; i++) {
      lista.add(i);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsSettings.colorPrimary,
        title: Text('Videojuegos'),
        actions: [
          Container(
            width: 150,
            child: TextField(
              onChanged: (texto) {
                busqueda = texto;
              },
              decoration: InputDecoration(
                  hintText: 'Buscar Juego',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.white),
                  )),
              style: TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            onPressed: () {
              if (busqueda.trim().compareTo('')==0) {
                ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(
                    content: Text('Ingrese algo')));
    }
              buscar(busqueda);
            },
            icon: const Icon(Icons.search),
          ),
        ],
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
        future: apipopular!.getgames(pagina),
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

  Future buscar(String busqueda) async{
    var orden = await apipopular!.getgamessearchcount(busqueda, 1);
    
    if (orden == 0) {
      print('Palabra a buscar  2  ' + orden.toString());
      ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
            content: Text(
                'No se encontro nada')));
    }else{
      double numpagesearch = orden!/20;
      if (numpagesearch>1000) {
        numpagesearch = 100;
      }
      print('Paginas de busqueda  ' + numpagesearch.ceil().toString());
      Navigator.pushNamed(
        context, 
        '/searchgame',
        arguments: {
          'paginas' : numpagesearch.ceil(),
          'busqueda' : busqueda,
        }
      );
      print('Palabra a buscar  2  ' + orden.toString());
    }
    
    
  }

 
}
