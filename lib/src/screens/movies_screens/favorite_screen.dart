import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/popular_movies_model.dart';
import 'package:practica2/src/utils/color_settings.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late DatabaseHelper _databaseHelper;
  
  
  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsSettings.colorPrimary,
        title: Text('Peliculas favoritas'),
      ),
      body: FutureBuilder(
        future: _databaseHelper.getAllFmovies(),
        builder:
            (BuildContext context, AsyncSnapshot<List<PopularMoviesModel>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Ocurrio un error en la petición'),
            );
          } else {
            if (snapshot.connectionState == ConnectionState.done) {
              return _listadoFmovies(snapshot.data!);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        },
      ),
    );
  }

  Widget _listadoFmovies(List<PopularMoviesModel> pelis) {
    

    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(Duration(seconds: 2), () {
          setState(() {});
        });
      },
      child: ListView.builder(
        itemBuilder: (BuildContext context, index) {
          PopularMoviesModel peli = pelis[index];
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black87,
                  offset: Offset(0, 5),
                  blurRadius: 2.5
                )
              ]
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
              alignment: Alignment.bottomCenter,
              children:[
                Container(
                  child: FadeInImage(
                    placeholder: AssetImage('assets/activity_indicator.gif'),
                    image: NetworkImage('https://image.tmdb.org/t/p/w500/${peli.backdropPath}'),
                    fadeInDuration: Duration(milliseconds: 200),
                  ),
                ),
                Opacity(
                  opacity: .5,
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    height: 60,
                    color: Colors.black,
                    child: Row( 
                      
                      children: <Widget>[
                        Flexible(child: Text(
                          peli.title!,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),),
                        Text(peli.backdropPath!),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:[ IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Confirmación'),
                                      content: Text('¿Estas segudo de quitar ${peli.title} de Favoritas?'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              _databaseHelper
                                                  .deletefavorite(peli.title!)
                                                  .then((noRows) {
                                                if (noRows > 0) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              'Se elimino a ${peli.title} de Favoritas')));
                                                  setState(() {});
                                                }
                                              });
                                            },
                                            child: Text('Si')),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('No'))
                                      ],
                                    );
                                  });
                            },
                            icon: Icon(Icons.delete),
                            color: Colors.white,
                            iconSize: 18,
                          ),] 
                        ),
                      ],
                    ),
                  ),
                )
              ] 
                    ),
            ),
          );

          Card(
            child: Column(
              children: [
                Text(
                  peli.title!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Confirmación'),
                                content: Text('¿Estas segudo de quitar ${peli.title} de Favoritas?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        _databaseHelper
                                            .deletefavorite(peli.title!)
                                            .then((noRows) {
                                          if (noRows > 0) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Se elimino a ${peli.title} de Favoritas')));
                                            setState(() {});
                                          }
                                        });
                                      },
                                      child: Text('Si')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('No'))
                                ],
                              );
                            });
                      },
                      icon: Icon(Icons.delete),
                      iconSize: 18,
                    ),
                  ],
                )
              ],
            ),
          );
        },
        itemCount: pelis.length,
      ),
    );
  }
}
