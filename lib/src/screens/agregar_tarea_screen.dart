import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/tareas_model.dart';
import 'package:practica2/src/utils/color_settings.dart';
import 'package:intl/intl.dart';

class AgregarTareaScreen extends StatefulWidget {
  TareasModel? tarea;
  AgregarTareaScreen({Key? key, this.tarea}) : super(key: key);

  @override
  _AgregarTareaScreenState createState() => _AgregarTareaScreenState();
}

class _AgregarTareaScreenState extends State<AgregarTareaScreen> {
  late DatabaseHelper _databaseHelper;

  TextEditingController _controllerNombre = TextEditingController();
  TextEditingController _controllerDescripcion = TextEditingController();
  TextEditingController _controllerDate = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    if (widget.tarea != null) {
      _controllerNombre.text = widget.tarea!.nomTarea!;
      _controllerDescripcion.text = widget.tarea!.dscTarea!;
      _controllerDate.text = widget.tarea!.fechaEntrega!.toString();
    }
    fechaentrega = new DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59);
    _controllerDate.text = (DateFormat('yyyy-MM-dd - kk:mm').format(fechaentrega!));
    _databaseHelper = DatabaseHelper();
  }

  DateTime? _selectDate,fechaentrega,fechahoy;
  
  void calldatepicker() async {
    var selectdate = await getdatepickerwidget();
    String formatofecha;
    setState(() {
      _selectDate = selectdate;
      if (_selectDate != null) {
        fechaentrega = new DateTime(
          _selectDate!.year, _selectDate!.month, _selectDate!.day, 23, 59, 59);
      }
      _controllerDate.text = (formatofecha = DateFormat('yyyy-MM-dd - kk:mm').format(fechaentrega!));
    });
  }

  Future<DateTime?> getdatepickerwidget() {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2022),
      builder: (context, child) {
        return Theme(data: ThemeData.dark(), child: child!);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String formatofecha;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsSettings.colorPrimary,
        title:
            widget.tarea == null ? Text('Agregar Tarea') : Text('Editar Tarea'),
      ),
      body: Center(
          child: new ListView(
        padding: const EdgeInsets.all(10),
        children: [
          _crearTextFieldNombre(),
          SizedBox(
            height: 10,
          ),
          _crearTextFieldDescripcion(),
          SizedBox(
            height: 10,
          ),
          _crearTextFieldFecha(),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              calldatepicker();
            },
            child: Text("Elegir fecha de entrega"),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              if (widget.tarea == null) {
                TareasModel tarea = TareasModel(
                  nomTarea: _controllerNombre.text,
                  dscTarea: _controllerDescripcion.text,
                  fechaEntrega: fechaentrega.toString(),
                  entregada: 0,
                );
                _databaseHelper.inserttarea(tarea.toMap()).then((value) {
                  if (value > 0) {
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('La solicitud no se completo')));
                  }
                });
              } else {
                TareasModel tarea = TareasModel(
                  idTarea: widget.tarea!.idTarea,
                  nomTarea: _controllerNombre.text,
                  dscTarea: _controllerDescripcion.text,
                  fechaEntrega: fechaentrega.toString(),
                  entregada: 0
                );

                _databaseHelper.updatetarea(tarea.toMap()).then((value) {
                  if (value > 0) {
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('La solicitud no se completo')));
                  }
                });
              }
              
            },
            child: Text('Guardar Tarea'),
          )
        ],
      )),
    );
  }

  Widget _crearTextFieldNombre() {
    return TextField(
      controller: _controllerNombre,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: "Nombre de la tarea",
          errorText: "Este campo es obligatorio"),
      onChanged: (value) {},
    );
  }

  Widget _crearTextFieldDescripcion() {
    return TextField(
      controller: _controllerDescripcion,
      keyboardType: TextInputType.text,
      maxLines: 8,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: "Detalle de la tarea",
          errorText: "Este campo es obligatorio"),
      onChanged: (value) {},
    );
  }

  Widget _crearTextFieldFecha() {
    return TextField(
      enabled: false,
      controller: _controllerDate,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: "Fecha de entrega de tarea",
          errorText: "Este campo es obligatorio"),
      onChanged: (value) {},
    );
  }

}
