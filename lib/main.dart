import 'package:flutter/material.dart';
import 'package:practica2/src/screens/agregar_nota_screen.dart';
import 'package:practica2/src/screens/agregar_tarea_screen.dart';
import 'package:practica2/src/screens/game_screens/game_detail_screen.dart';
import 'package:practica2/src/screens/game_screens/videogames_screen.dart';
import 'package:practica2/src/screens/game_screens/videogames_search_screen%20.dart';
import 'package:practica2/src/screens/intenciones_screen.dart';
import 'package:practica2/src/screens/movies_screens/detail_screen.dart';
import 'package:practica2/src/screens/movies_screens/favorite_screen.dart';
import 'package:practica2/src/screens/movies_screens/popular_screen.dart';
import 'package:practica2/src/screens/notas_screen.dart';
import 'package:practica2/src/screens/opcion1_screen.dart';
import 'package:practica2/src/screens/profile_screen.dart';
import 'package:practica2/src/screens/splash_screen.dart';
import 'package:practica2/src/screens/tareas_entregadas_screen%20.dart';
import 'package:practica2/src/screens/tareas_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/opc1'           : (BuildContext context) => Opcion1Screen(),
        '/intenciones'    : (BuildContext context) => IntencionesScreen(),
        '/notas'          : (BuildContext context) => NotasScreen(),
        '/agregar'        : (BuildContext context) => AgregarNotaScreen(),
        '/perfil'         : (BuildContext context) => PerfilScreen(),
        '/tareas'         : (BuildContext context) => TareasScreen(),
        '/agregartarea'   : (BuildContext context) => AgregarTareaScreen(),
        '/tareaentregada' : (BuildContext context) => TareasEntregadasScreen(),
        '/movie'          : (BuildContext context) => PopularScreen(),
        '/detail'         : (BuildContext context) => DetailScreen(),
        '/favoritas'      : (BuildContext context) => FavoriteScreen(),
        '/videojuegos'    : (BuildContext context) => VideoGamesScreen(),
        '/gamedetail'     : (BuildContext context) => GameDetailScreen(),
        '/searchgame'     : (BuildContext context) => VideoGamesSearchScreen(),
        
      },
      debugShowCheckedModeBanner: false,
      
      home: SplashScreen(),
    );
  }
}