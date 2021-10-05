import 'package:flutter/material.dart';
import 'package:practica2/src/screens/agregar_nota_screen.dart';
import 'package:practica2/src/screens/intenciones_screen.dart';
import 'package:practica2/src/screens/notas_screen.dart';
import 'package:practica2/src/screens/opcion1_screen.dart';
import 'package:practica2/src/screens/profile_screen.dart';
import 'package:practica2/src/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/opc1'         : (BuildContext context) => Opcion1Screen(),
        '/intenciones'  : (BuildContext context) => IntencionesScreen(),
        '/notas'        : (BuildContext context) => NotasScreen(),
        '/agregar'      : (BuildContext context) => AgregarNotaScreen(),
        '/perfil'      : (BuildContext context) => PerfilScreen(),
      },
      debugShowCheckedModeBanner: false,
      
      home: SplashScreen(),
    );
  }
}