
class PerfilModel {
  int? id, telefono;
  String? nombre, a_paterno, a_materno, correo;
  //File? avatar;

  PerfilModel({this.id,this.nombre,this.a_paterno,this.a_materno,this.correo,this.telefono});

  //Map -> Object
  factory PerfilModel.fromMap(Map<String, dynamic> map) {
    return PerfilModel(
      id: map['id'],
      nombre: map['nombre'],
      a_paterno: map['a_paterno'],
      a_materno: map['a_materno'],
      correo: map['correo'],
      telefono: map['telefono'],
    );
  }

  //Object -> Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'a_paterno': a_paterno,
      'a_materno': a_materno,
      'correo': correo,
      'telefono': telefono,
    };
  }

  
}

  

