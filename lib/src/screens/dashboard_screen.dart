import 'package:flutter/material.dart';
import 'package:practica2/src/utils/color_settings.dart';

class DaashBoardScreen extends StatelessWidget {
  const DaashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DASHBOARD'),
        backgroundColor: ColorsSettings.colorPrimary,  
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Oscar Barron'), 
              accountEmail: Text('oscar_barr@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes.png'),
                //child: Icon(Icons.verified_user)
              ),
              decoration: BoxDecoration(
                color: ColorsSettings.colorPrimary
              ),
            ),
            ListTile(
              title: Text('Propinas'),
              subtitle: Text('Calculadora de propinas'),
              leading: Icon(Icons.monetization_on),
              trailing: Icon(Icons.chevron_right),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, '/opc1');
              },
            ),
            ListTile(
              title: Text('Intenciones'),
              subtitle: Text('Intenciones implicitas'),
              leading: Icon(Icons.phone_android),
              trailing: Icon(Icons.chevron_right),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, '/intenciones');
              },
            ),
            ListTile(
              title: Text('Notas'),
              subtitle: Text('CRUD Notas'),
              leading: Icon(Icons.note),
              trailing: Icon(Icons.chevron_right),
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, '/notas');
              },
            )
          ], 
        )
      ),
    );
  }
}