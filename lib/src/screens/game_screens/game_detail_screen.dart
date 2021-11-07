import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practica2/src/models/games_model.dart';
import 'package:practica2/src/network/api_popular.dart';
import 'package:practica2/src/utils/color_settings.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class GameDetailScreen extends StatefulWidget {
  const GameDetailScreen({Key? key}) : super(key: key);

  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  ApiPopular? apipopular;

  @override
  Widget build(BuildContext context) {
    apipopular = ApiPopular();
    final game =
      ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    const colorizeColors = [
      Colors.pink,
      Colors.purple,
      Colors.blue,
      Colors.cyan,
      Colors.teal,
      Colors.green,
      Colors.yellow,
      Colors.orange,
      Colors.red,
    ];
    return Scaffold(
      backgroundColor: Colors.grey.shade600,
      appBar: AppBar(
        title: Text(game['name']),
        backgroundColor: ColorsSettings.colorPrimary,
      ),
      body: SizedBox.expand(
        child: DraggableScrollableSheet(
          initialChildSize: 0.99,
          minChildSize: .99,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              child: ListView.separated(
                controller: scrollController,
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Image.network(game['background_image'] == null
                            ? 'https://blogdigital.es/wp-content/uploads/2015/09/imagen-no-encontrada.jpg'
                            : game['background_image']),
                        padding: EdgeInsets.all(10),
                      ),
                      
                      Container(
                        color: Colors.grey[900],
                        child: ListTile(
                          title: Center(
                            child: AnimatedTextKit(
                              animatedTexts: [
                                FlickerAnimatedText(
                                  'Deslizas las tarjetas para ver la informacion',
                                  textStyle:  GoogleFonts.kanit(
                                    textStyle: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.white,
                                      
                                      fontSize: 18,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 15.0,
                                          color: Colors.pink,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                              repeatForever: true,
                            ),
                          ),
                        ),
                      ),
                      
                      
                      SizedBox(
                        height: 10,
                      ),
                      Slidable(
                        actionPane: SlidableStrechActionPane(),
                        actionExtentRatio: 1,
                        child: Container(
                          height: 300,
                          color: Colors.grey[900],
                          child: Center(
                            child: ListTile(
                              
                              title:  Center(
                                child: AnimatedTextKit(
                                  animatedTexts: [
                                    ColorizeAnimatedText(
                                      'Descipcion del juego',
                                      textStyle: GoogleFonts.kanit(
                                        textStyle: TextStyle(
                                          decoration: TextDecoration.none,
                                          color: Colors.white,
                                          fontSize: 30
                                        ),
                                      ),
                                      colors: colorizeColors,
                                      speed: Duration(milliseconds: 250),
                                    ),
                                    
                                  ],
                                  pause: Duration(milliseconds: 1),
                                  repeatForever: true,
                                ),
                              ),
                              
                            ),
                          ),
                        ),
                        secondaryActions: <Widget>[
                          Center(
                            child: FutureBuilder(
                              future: apipopular!.getdescription(game['id']),
                              builder: (BuildContext context,
                                  AsyncSnapshot<String?> snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text('Error en la peticion'),
                                  );
                                } else {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return _descripcion(snapshot.data);
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                        actions: <Widget>[
                          Center(
                            child: FutureBuilder(
                              future: apipopular!.getdescription(game['id']),
                              builder: (BuildContext context,
                                  AsyncSnapshot<String?> snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text('Error en la peticion'),
                                  );
                                } else {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return _descripcion(snapshot.data);
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                     
                      SizedBox(
                        height: 10,
                      ),
                      Slidable(
                        actionPane: SlidableStrechActionPane(),
                        actionExtentRatio: 1,
                        child: Container(
                          color: Colors.grey[900],
                          child: ListTile(
                            title: Center(
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  ColorizeAnimatedText(
                                    'Generos del juego',
                                    textStyle: GoogleFonts.kanit(
                                      textStyle: TextStyle(
                                        decoration: TextDecoration.none,
                                        color: Colors.white,
                                        fontSize: 30
                                      ),
                                    ),
                                    colors: colorizeColors,
                                    speed: Duration(milliseconds: 250),
                                  ),
                                  
                                ],
                                pause: Duration(milliseconds: 1),
                                repeatForever: true,
                              ),
                            ),
                          ),
                        ),
                        secondaryActions: <Widget>[
                          Center(
                            child: FutureBuilder(
                              future: apipopular!.getgamegenres(game['id']),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<GamesModel>?> snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text('Error en la peticion'),
                                  );
                                } else {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return _generos(snapshot.data);
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                        actions: <Widget>[
                          Center(
                            child: FutureBuilder(
                              future: apipopular!.getgamegenres(game['id']),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<GamesModel>?> snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text('Error en la peticion'),
                                  );
                                } else {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return _generos(snapshot.data);
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(
                        height: 10,
                      ),
                      Slidable(
                        actionPane: SlidableStrechActionPane(),
                        actionExtentRatio: 1,
                        child: Container(
                          color: Colors.grey[900],
                          child: ListTile(
                            title: Center(
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  ColorizeAnimatedText(
                                    'Puntuacion en Metacritic',
                                    textStyle: GoogleFonts.kanit(
                                      textStyle: TextStyle(
                                        decoration: TextDecoration.none,
                                        color: Colors.white,
                                        fontSize: 30
                                      ),
                                    ),
                                    colors: colorizeColors,
                                    speed: Duration(milliseconds: 250),
                                  ),
                                  
                                ],
                                pause: Duration(milliseconds: 1),
                                repeatForever: true,
                              ),
                            ),
                          ),
                        ),
                        secondaryActions: <Widget>[
                          Center(
                            child: game['metacritic'] == null
                                ? Card(
                                    color: Colors.red,
                                    child: Text(
                                      'Sin puntuacion',
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          color: Colors.white,
                                          fontSize: 30),
                                    ),
                                  )
                                : Card(
                                    color: game['metacritic'] >= 75
                                        ? Colors.green
                                        : game['metacritic'] >= 50
                                            ? Colors.orange
                                            : Colors.red,
                                    child: Text(
                                      game['metacritic'].toString(),
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          color: Colors.white,
                                          fontSize: 30),
                                    ),
                                  ),
                          )
                        ],
                        actions: <Widget>[
                          Center(
                            child: game['metacritic'] == null
                                ? Card(
                                    color: Colors.red,
                                    child: Text(
                                      'Sin puntuacion',
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          color: Colors.white,
                                          fontSize: 30),
                                    ),
                                  )
                                : Card(
                                    color: game['metacritic'] >= 75
                                        ? Colors.green
                                        : game['metacritic'] >= 50
                                            ? Colors.orange
                                            : Colors.red,
                                    child: Text(
                                      game['metacritic'].toString(),
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          color: Colors.white,
                                          fontSize: 30),
                                    ),
                                  ),
                          )
                        ],
                      ),
                     
                      SizedBox(
                        height: 10,
                      ),
                      Slidable(
                        actionPane: SlidableStrechActionPane(),
                        actionExtentRatio: 1,
                        child: Container(
                          color: Colors.grey[900],
                          child: ListTile(
                            title: Center(
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  ColorizeAnimatedText(
                                    'Desarrollador',
                                    textStyle: GoogleFonts.kanit(
                                      textStyle: TextStyle(
                                        decoration: TextDecoration.none,
                                        color: Colors.white,
                                        fontSize: 30
                                      ),
                                    ),
                                    colors: colorizeColors,
                                    speed: Duration(milliseconds: 250),
                                  ),
                                ],
                                
                                pause: Duration(milliseconds: 1),
                                repeatForever: true,
                              )
                              
                            ),
                          ),
                        ),
                        secondaryActions: <Widget>[
                          Center(
                            child: FutureBuilder(
                              future: apipopular!.getgamedevelopers(game['id']),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<GamesModel>?> snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text('Error en la peticion'),
                                  );
                                } else {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return _desarrollador(snapshot.data);
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                        actions: <Widget>[
                          Center(
                            child: FutureBuilder(
                              future: apipopular!.getgamedevelopers(game['id']),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<GamesModel>?> snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text('Error en la peticion'),
                                  );
                                } else {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return _desarrollador(snapshot.data);
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                }
                              },
                            ),
                          ),
                          
                        
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Slidable(
                        actionPane: SlidableStrechActionPane(),
                        actionExtentRatio: 1,
                        child: Container(
                          color: Colors.grey[900],
                          child: ListTile(
                            title: Center(
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  
                                  ColorizeAnimatedText(
                                    'Publisher',
                                    textStyle: GoogleFonts.kanit(
                                      textStyle: TextStyle(
                                        decoration: TextDecoration.none,
                                        color: Colors.white,
                                        fontSize: 30
                                      ),
                                    ), 
                                    colors: colorizeColors,
                                    speed: Duration(milliseconds: 250),
                                  ),
                                ],
                                
                                pause: Duration(milliseconds: 1),
                                repeatForever: true,
                              )
                              
                            ),
                          ),
                        ),
                        secondaryActions: <Widget>[
                          Center(
                            child: FutureBuilder(
                              future: apipopular!.getpublisher(game['id']),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<GamesModel>?> snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text('Error en la peticion'),
                                  );
                                } else {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return _publisher(snapshot.data);
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                        actions: <Widget>[
                          Center(
                            child: FutureBuilder(
                              future: apipopular!.getpublisher(game['id']),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<GamesModel>?> snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text('Error en la peticion'),
                                  );
                                } else {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return _publisher(snapshot.data);
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                }
                              },
                            ),
                          ),
                          
                        
                        ],
                      ),
                      
                      SizedBox(
                        height: 10,
                      ),
                      Slidable(
                        actionPane: SlidableStrechActionPane(),
                        actionExtentRatio: .9,
                        child: Container(
                          color: Colors.grey[900],
                          child: ListTile(
                            title: Center(
                              
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  ColorizeAnimatedText(
                                    'Plataformas',
                                    textStyle: GoogleFonts.kanit(
                                      textStyle: TextStyle(
                                        decoration: TextDecoration.none,
                                        color: Colors.white,
                                        fontSize: 30
                                      ),
                                    ),
                                    colors: colorizeColors,
                                    speed: Duration(milliseconds: 250),
                                  ),
                                  
                                ],
                                pause: Duration(milliseconds: 1),
                                repeatForever: true,
                                
                                
                              ),
                            ),
                          ),
                        ),
                        secondaryActions: <Widget>[
                          
                          Center(
                            child: FutureBuilder(
                              future: apipopular!.getgameplataforms(game['id']),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<String>?> snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text('Error en la peticion'),
                                  );
                                } else {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return _plataformas(snapshot.data);
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                        actions: <Widget>[
                          Center(
                            child: FutureBuilder(
                              future: apipopular!.getgameplataforms(game['id']),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<String>?> snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text('Error en la peticion'),
                                  );
                                } else {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return _plataformas(snapshot.data);
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            );
          },
        ),
      ),
    );
    //
  }

  Widget _descripcion(String? juego) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Text(
        juego == null ? 'Regargar pagina' : juego.replaceAll("<p>", "").replaceAll("<br />", "\n").replaceAll("</p>", ""),
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            decoration: TextDecoration.none,
            color: Colors.white,
            fontSize: 15
          ),
        ),
      ),
    );
  }

  Widget _generos(List<GamesModel>? genres) {
    if (genres == null) {
      return Text('No se encontraron los Generos de este juego');
    } else {
      print('no null');
      for (int i = 0; i < genres.length; i++) {
        print(genres[i].genero);
      }
      return SizedBox(
        height: 32,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (Context, index) {
              String? gen = genres[index].genero;
              return Text(
                ' ' + gen!,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontSize: 15
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => VerticalDivider(
                  color: Colors.transparent,
                  width: 5,
                ),
            itemCount: genres.length),
      );
    }
  }

  Widget _plataformas(List<String>? plataforms) {
    if (plataforms == null) {
      return Text('No se encontraron los Generos de este juego');
    } else {
      print('no null');
      for (int i = 0; i < plataforms.length; i++) {
        print(plataforms[i]);
      }
      return SizedBox(
        height: 32,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (Context, index) {
              String? plat = plataforms[index];
              return Text(
                ' ' + plat + ' ' ,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontSize: 15
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => VerticalDivider(
                  color: Colors.transparent,
                  width: 5,
                ),
            itemCount: plataforms.length),
      );
    }
  }


  Widget _desarrollador(List<GamesModel>? desarrolladores) {
    if (desarrolladores == null) {
      return Text('No se encontraron los Generos de este juego');
    } else {
      print('no null');
      for (int i = 0; i < desarrolladores.length; i++) {
        print(desarrolladores[i].devname);
      }
      return SizedBox(
        height: 32,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (Context, index) {
              String? developer = desarrolladores[index].devname;
              return Text(
                ' ' + developer!+' ',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontSize: 15
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => VerticalDivider(
                  color: Colors.transparent,
                  width: 5,
                ),
            itemCount: desarrolladores.length),
      );
    }
  }

  Widget _publisher(List<GamesModel>? publisher) {
    if (publisher == null) {
      return Text('No se encontraron los Generos de este juego');
    } else {
      print('no null');
      for (int i = 0; i < publisher.length; i++) {
        print(publisher[i].publiname);
      }
      return SizedBox(
        height: 32,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (Context, index) {
              String? publish = publisher[index].publiname;
              return Text(
                ' ' + publish!+' ',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontSize: 15
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => VerticalDivider(
                  color: Colors.transparent,
                  width: 5,
                ),
            itemCount: publisher.length),
      );
    }
  }

}
