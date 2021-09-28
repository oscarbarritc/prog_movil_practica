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
            
          )
          
    
        ],
      ),
    );
  }
}