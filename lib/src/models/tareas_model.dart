import 'package:flutter/material.dart';

class TareasModel {
  int? idTarea,entregada;
  String? nomTarea,dscTarea,fechaEntrega;

  //bool? entregada;

  TareasModel({this.idTarea, this.nomTarea, this.dscTarea,this.fechaEntrega, this.entregada});

  //Map -> Object
  factory TareasModel.fromMap(Map<String, dynamic> map) {
    return TareasModel(
      idTarea: map['idTarea'],
      nomTarea: map['nomTarea'],
      dscTarea: map['dscTarea'],
      fechaEntrega: map['fechaEntrega'],
      entregada: map['entregada'],
    );
  }

  //Object -> Map
  Map<String, dynamic> toMap() {
    return {
      'idTarea': idTarea,
      'nomTarea': nomTarea,
      'dscTarea': dscTarea,
      'fechaEntrega': fechaEntrega,
      'entregada': entregada,
    };
  }
}
