class NotasModel {
  int? id;
  String? titulo, detalle;


  NotasModel({this.id, this.titulo, this.detalle});

  //Map -> Object
  factory NotasModel.fromMap(Map<String, dynamic> map) {
    return NotasModel(
      id: map['id'],
      titulo: map['titulo'],
      detalle: map['detalle'],
    );
  }

  //Object -> Map
  Map<String, dynamic> toMap() {
    return {
      'id'  : id,
      'titulo'  : titulo,
      'detalle'  : detalle,
    };
  }


}


