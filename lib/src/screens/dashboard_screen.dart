import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/perfil_model.dart';
import 'package:practica2/src/utils/color_settings.dart';

class DaashBoardScreen extends StatefulWidget {
  const DaashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DaashBoardScreen> createState() => _DaashBoardScreenState();
}

class _DaashBoardScreenState extends State<DaashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    DatabaseHelper _databaseHelper = DatabaseHelper();
    return Scaffold(
      body: FutureBuilder(
        future: _databaseHelper.getAllnperfil(),
        builder:
            (BuildContext context, AsyncSnapshot<List<PerfilModel>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Ocurrio un error en la petición'),
            );
          } else {
            if (snapshot.connectionState == ConnectionState.done) {
              return constructor(context, snapshot.data!);
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

  Widget constructor(BuildContext context, List<PerfilModel> perfiles) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DASHBOARD'),
        backgroundColor: ColorsSettings.colorPrimary,
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(perfiles[0].nombre!),
            accountEmail: Text(perfiles[0].correo!),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes.png'),
              
            ),
            onDetailsPressed: () {
              Navigator.pushNamed(context, '/perfil').then((value) {
                  setState(() {});
                });
            },
            decoration: BoxDecoration(color: ColorsSettings.colorPrimary),
          ),
          ListTile(
            title: Text('Propinas'),
            subtitle: Text('Calculadora de propinas'),
            leading: Icon(Icons.monetization_on),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/opc1');
            },
          ),
          ListTile(
            title: Text('Intenciones'),
            subtitle: Text('Intenciones implicitas'),
            leading: Icon(Icons.phone_android),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/intenciones');
            },
          ),
          ListTile(
            title: Text('Notas'),
            subtitle: Text('CRUD Notas'),
            leading: Icon(Icons.note),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/notas');
            },
          ),
          ListTile(
            title: Text('Tareas'),
            subtitle: Text('Tareas que nos han dejado'),
            leading: Icon(Icons.event_note),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/tareas');
            },
          ),
          ListTile(
            title: Text('Movies'),
            subtitle: Text('Prueba api'),
            leading: Icon(Icons.movie),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/movie');
            },
          ),
          ListTile(
            title: Text('Video Juegos'),
            subtitle: Text('Lista de videojuegos'),
            leading: Icon(Icons.gamepad),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/videojuegos');
            },
          ),
        ],
      )),
    );
  }
}
