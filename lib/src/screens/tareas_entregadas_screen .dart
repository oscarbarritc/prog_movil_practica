import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/tareas_model.dart';
import 'package:practica2/src/utils/color_settings.dart';

class TareasEntregadasScreen extends StatefulWidget {
  const TareasEntregadasScreen({Key? key}) : super(key: key);

  @override
  State<TareasEntregadasScreen> createState() => _TareasEntregadasScreenState();
}

class _TareasEntregadasScreenState extends State<TareasEntregadasScreen> {
  late DatabaseHelper _databaseHelper;
  bool cbvalue = false;

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
        title: Text('Tareas entregadas'),
      ),
      body: FutureBuilder(
        future: _databaseHelper.getAlltareasEntregadas(),
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
              ],
            ),
          );
        },
        itemCount: tareas.length,
      ),
    );
  }
}
