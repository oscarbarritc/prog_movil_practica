import 'package:flutter/material.dart';
import 'package:practica2/src/utils/color_settings.dart';

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
                child: Icon(Icons.language,color: Colors.black,),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(width: 1.0))
                ),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: (){},
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
                child: Icon(Icons.phone_android,color: Colors.black,),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(width: 1.0))
                ),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: (){},
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
                child: Icon(Icons.sms_sharp,color: Colors.black,),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(width: 1.0))
                ),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: (){},
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
                  Text('To: oscar.barron@itcelaya.edu'),
                ],
              ),
              leading: Container(
                height: 40,
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.email_outlined,color: Colors.black,),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(width: 1.0))
                ),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: (){},
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
                child: Icon(Icons.camera_alt_outlined,color: Colors.black,),
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(width: 1.0))
                ),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: (){},
            ),
          )
          
    
        ],
      ),
    );
  }
   
   abrirweb()
   {

   }

   llamadaeelefonica()
   {
     
   }

   enviarsms()
   {
     
   }

   enviaremail()
   {
     
   }

   tomarfoto()
   {
     
   }


}