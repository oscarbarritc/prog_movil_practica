import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/tareas_model.dart';
import 'package:practica2/src/screens/agregar_tarea_screen.dart';
import 'package:practica2/src/utils/color_settings.dart';

class TareasScreen extends StatefulWidget {
  const TareasScreen({Key? key}) : super(key: key);

  @override
  State<TareasScreen> createState() => _TareasScreenState();
}

class _TareasScreenState extends State<TareasScreen> {
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
        title: Text('Gestion de Tareas'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/tareaentregada');
              },
              icon: Icon(Icons.library_add_check_outlined)),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/agregartarea').whenComplete((){setState(() {});});
              },
              icon: Icon(Icons.post_add))
        ],
      ),
      body: FutureBuilder(
        future: _databaseHelper.getAlltareas(),
        builder:
            (BuildContext context, AsyncSnapshot<List<TareasModel>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Ocurrio un error en la petición'),
            );
          } else {
            if (snapshot.connectionState == ConnectionState.done) {
              return _listadoTareas(snapshot.data!);
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

  Widget _listadoTareas(List<TareasModel> tareas) {
    DateTime now = DateTime.now();
    DateTime dateentrega;
    String formatofecha;
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(Duration(seconds: 2), () {
          setState(() {});
        });
      },
      child: ListView.builder(
        itemBuilder: (BuildContext context, index) {
          TareasModel tarea = tareas[index];
          dateentrega = DateTime.parse(tarea.fechaEntrega!);
          
          return Card(
            child: Column(
              children: [
                
                now.isBefore(dateentrega)
                    ? Text('Estas a tiempo de entregar la tarea',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            backgroundColor: Colors.teal[900]))
                    : Text('Ya debiste de haber entregado esta tarea',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            backgroundColor: Colors.red)),
                Text(
                  formatofecha =
                      DateFormat('yyyy-MM-dd - kk:mm').format(dateentrega),
                ),
                Text(
                  tarea.nomTarea!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(tarea.dscTarea!),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: (){
                    TareasModel tareacargada = TareasModel(
                      idTarea: tarea.idTarea,
                      nomTarea: tarea.nomTarea,
                      dscTarea: tarea.dscTarea,
                      fechaEntrega: tarea.fechaEntrega,
                      entregada: 1
                    );
                    _databaseHelper.updatetarea(tareacargada.toMap()).then((value) {
                      if (value > 0) {
                        setState(() {
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('La solicitud no se completo')));
                      }
                    }); 
                  }, 
                  child: Column(
                    children: [
                      Text("Entregar Tarea"),
                      SizedBox(
                        height: 5,
                      ),
                      Icon(Icons.check_circle_outline_outlined),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink[400],
                    onPrimary: Colors.white,
                    shadowColor: Colors.orange,
                    elevation: 20,
                    
                    
                  )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AgregarTareaScreen(
                                      tarea: tarea,
                                    )));
                      },
                      icon: Icon(Icons.edit),
                      iconSize: 18,
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Confirmación'),
                                content: Text('¿Estas seguro de borrar la tarea?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        _databaseHelper
                                            .deletetarea(tarea.idTarea!)
                                            .then((noRows) {
                                          if (noRows > 0) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'El registro se ha elimindo')));
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
        itemCount: tareas.length,
      ),
    );
  }
}
