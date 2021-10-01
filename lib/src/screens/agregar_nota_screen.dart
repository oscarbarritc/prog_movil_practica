import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/notas_model.dart';
import 'package:practica2/src/utils/color_settings.dart';

class AgregarNotaScreen extends StatefulWidget {
  AgregarNotaScreen({Key? key}) : super(key: key);

  @override
  _AgregarNotaScreenState createState() => _AgregarNotaScreenState();
}

class _AgregarNotaScreenState extends State<AgregarNotaScreen> {
  late DatabaseHelper _databaseHelper;

  TextEditingController _controllerTitulo = TextEditingController();
  TextEditingController _controllerDetalle = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsSettings.colorPrimary,
        title: Text('Agregar Nota'),
      ),
      body: ListView(
        children: [
          _crearTextFieldTitulo(),
          SizedBox(height: 10,),
          _crearTextFieldDetalle(),
          ElevatedButton(
            onPressed: () {
              NotasModel nota = NotasModel(
                  titulo: _controllerTitulo.text,
                  detalle: _controllerDetalle.text);

              _databaseHelper.insert(nota.toMap()).then((value) {
                if (value > 0) {
                  // Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Registro insertado correctamente'))
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('La solicitud no se completo'))
                  );
                }
              });
            },
            child: Text('Guardar Nota'),
          )
        ],
      ),
    );
  }

  Widget _crearTextFieldTitulo() {
    return TextField(
      controller: _controllerTitulo,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: "Titulo de la nota",
          errorText: "Este campo es obligatorio"),
      onChanged: (value) {},
    );
  }

  Widget _crearTextFieldDetalle() {
    return TextField(
      controller: _controllerDetalle,
      keyboardType: TextInputType.text,
      maxLines: 8,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: "Detalle de la nota",
          errorText: "Este campo es obligatorio"),
      onChanged: (value) {},
    );
  }
}