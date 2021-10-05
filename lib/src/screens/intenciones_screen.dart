import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practica2/src/utils/color_settings.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';

class IntencionesScreen extends StatefulWidget {
  IntencionesScreen({Key? key}) : super(key: key);

  @override
  _IntencionesScreenState createState() => _IntencionesScreenState();
}

class _IntencionesScreenState extends State<IntencionesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Intenciones Implicitas'),
        backgroundColor: ColorsSettings.colorPrimary,
      ),
      body: ListView(
        children: [
          Card(
            elevation: 8.0,
            child: ListTile(
              tileColor: Colors.white54,
              title: Text('Abrir pagina web'),
              subtitle: Row(
                children: [
                  Icon(Icons.touch_app_rounded, size: 18, color: Colors.red),
                  Text('https://celaya.tecnm.mx/'),
                ],
              ),
              leading: Container(
                height: 40,
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.language,
                  color: Colors.black,
                ),
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(width: 1.0))),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _abrirweb,
            ),
          ),
          Card(
            elevation: 8.0,
            child: ListTile(
              tileColor: Colors.white54,
              title: Text('Llamada telefonica'),
              subtitle: Row(
                children: [
                  Icon(Icons.touch_app_rounded, size: 18, color: Colors.red),
                  Text('Cel: 4431686363'),
                ],
              ),
              leading: Container(
                height: 40,
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.phone_android,
                  color: Colors.black,
                ),
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(width: 1.0))),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _llamadaeelefonica,
            ),
          ),
          Card(
            elevation: 8.0,
            child: ListTile(
              tileColor: Colors.white54,
              title: Text('Enviar SMS'),
              subtitle: Row(
                children: [
                  Icon(Icons.touch_app_rounded, size: 18, color: Colors.red),
                  Text('Cel: 4431686363'),
                ],
              ),
              leading: Container(
                height: 40,
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.sms_sharp,
                  color: Colors.black,
                ),
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(width: 1.0))),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _enviarsms,
            ),
          ),
          Card(
            elevation: 8.0,
            child: ListTile(
              tileColor: Colors.white54,
              title: Text('Enviar Email'),
              subtitle: Row(
                children: [
                  Icon(Icons.touch_app_rounded, size: 18, color: Colors.red),
                  Text('To: 18030472@itcelaya.edu.mx'),
                ],
              ),
              leading: Container(
                height: 40,
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.email_outlined,
                  color: Colors.black,
                ),
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(width: 1.0))),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _enviaremail,
            ),
          ),
          Card(
            elevation: 8.0,
            child: ListTile(
              tileColor: Colors.white54,
              title: Text('Tomar Foto'),
              subtitle: Row(
                children: [
                  Icon(Icons.touch_app_rounded, size: 18, color: Colors.red),
                  Text('Sonrie'),
                ],
              ),
              leading: Container(
                height: 40,
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.black,
                ),
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(width: 1.0))),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _tomarfoto,
            ),
          )
        ],
      ),
    );
  }

  _abrirweb() async {
    const url = "https://celaya.tecnm.mx/";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _llamadaeelefonica() async {
    const url = "tel:4431686363";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _enviarsms() async {
    const url = "sms:4431686363";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _enviaremail() async {
    final Uri params = Uri(
        scheme: 'mailto',
        path: '18030472@itcelaya.edu.mx',
        query: 'subject=Saludos&body=Bienvenido :)');

    var email = params.toString();
    if (await canLaunch(email)) {
      await launch(email);
    }
  }

  _tomarfoto() async {
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.camera);
    print("object");
    print(image);
  }
}
