import 'package:flutter/material.dart';
import 'package:practica2/src/utils/color_settings.dart';

class Opcion1Screen extends StatefulWidget {
  Opcion1Screen({Key? key}) : super(key: key);
  @override
  _PropinaScreen createState() => _PropinaScreen();
}

class _PropinaScreen extends State<Opcion1Screen> {
  var isLoading = false;
  var total, titulo, contenido;
  TextEditingController txtcuenta = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextFormField txtmonto = TextFormField(
      controller: txtcuenta,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          hintText: 'Introduce el monto del consumo',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5)),
    );

    ElevatedButton btncalpropina = ElevatedButton(
        style: ElevatedButton.styleFrom(primary: ColorsSettings.colorButton),
        onPressed: () {
          if (txtcuenta.text.isNotEmpty) {
            total = txtcuenta.text
                .toString()
                .replaceAll(",", ".")
                .replaceAll("-", "")
                .replaceAll(" ", "");
            total = double.parse(total.toString()) * 1.15;
            titulo = "El total con 15% de propina es:";
            contenido = "El total es \$ $total";
          } else {
            titulo = "ALERTA";
            contenido = "Por favor ingrese el monto para calcular su propina";
          }
          _showAlertDialog(titulo, contenido);

          setState(() {});
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.monetization_on),
            Text('Calcular total con propina')
          ],
        ));

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/comida.jpg'), fit: BoxFit.fill)),
        ),
        Card(
          margin: EdgeInsets.only(left: 15, right: 15, bottom: 500),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                txtmonto,
                SizedBox(
                  height: 5,
                ),
                btncalpropina
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showAlertDialog(String titulo, String contenido) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(contenido),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "CERRAR",
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
