import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/perfil_model.dart';
import 'package:practica2/src/utils/color_settings.dart';

class PerfilScreen extends StatefulWidget {
  PerfilModel? perfil;
  PerfilScreen({Key? key, this.perfil}) : super(key: key);

  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  late DatabaseHelper _databaseHelper;

  TextEditingController _controllerNombre = TextEditingController();
  TextEditingController _controllerPaterno = TextEditingController();
  TextEditingController _controllerMaterno = TextEditingController();
  TextEditingController _controllerCorreo = TextEditingController();
  TextEditingController _controllerTelefono = TextEditingController();
  //TextEditingController _controllerAvatar = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    // if (widget.perfil != null) {
    //   _controllerNombre.text = widget.perfil!.nombre!;
    //   _controllerPaterno.text = widget.perfil!.a_paterno!;
    //   _controllerMaterno.text = widget.perfil!.a_materno!;
    //   _controllerCorreo.text = widget.perfil!.correo!;
    //   _controllerTelefono.text = widget.perfil!.telefono!.toString();
    // }
    super.initState();
    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsSettings.colorPrimary,
        title: Text('Editar perfil'),
      ),
      body: FutureBuilder(
        future: _databaseHelper.getAllnperfil(),
        builder:
            (BuildContext context, AsyncSnapshot<List<PerfilModel>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Ocurrio un error en la petición'),
            );
          } else {
            if (snapshot.connectionState == ConnectionState.done) {
              return _listadoPerfiles(snapshot.data!);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        },
      ),
    );
  }

  void aaa(PerfilModel user) {
    _controllerNombre.text = user.nombre!;
    _controllerPaterno.text = user.a_paterno!;
    _controllerMaterno.text = user.a_materno!;
    _controllerCorreo.text = user.correo!;
    _controllerTelefono.text = user.telefono!.toString();
  }

  Widget _listadoPerfiles(List<PerfilModel> perfiles) {
    aaa(perfiles[0]);
    return Scaffold(
      body: Center(
          child: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          _crearTextFieldNombre(),
          SizedBox(
            height: 10,
          ),
          _crearTextFieldPaterno(),
          SizedBox(
            height: 10,
          ),
          _crearTextFieldMaterno(),
          SizedBox(
            height: 10,
          ),
          _crearTextFieldCorreo(),
          SizedBox(
            height: 10,
          ),
          _crearTextFieldTelefono(),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (perfiles == null) {
                  PerfilModel usr = PerfilModel(
                    nombre: _controllerNombre.text,
                    a_paterno: _controllerPaterno.text,
                    a_materno: _controllerMaterno.text,
                    correo: _controllerCorreo.text,
                    telefono: int.parse(_controllerTelefono.text),
                  );
                  _databaseHelper.insertuser(usr.toMap()).then((value) {
                    if (value > 0) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text('La solicitud se completo correctamente')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('La solicitud no se completo')));
                    }
                  });
                } else {
                  PerfilModel usuario2 = perfiles[0];
                  usuario2 = PerfilModel(
                    id: usuario2.id,
                    nombre: _controllerNombre.text,
                    a_paterno: _controllerPaterno.text,
                    a_materno: _controllerMaterno.text,
                    correo: _controllerCorreo.text,
                    telefono: int.parse(_controllerTelefono.text),
                  );
                  _databaseHelper.updateuser(usuario2.toMap()).then((value) {
                    if (value > 0) {
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('La solicitud no se completo')));
                    }
                  }
                  );
                }
              });
            },
            child: Text('Guardar Perfil'),
          )
        ],
      )),
    );
  }

  Widget _crearTextFieldNombre() {
    return TextField(
      controller: _controllerNombre,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: "Nombre",
          errorText: "Este campo es obligatorio"),
      onChanged: (value) {},
    );
  }

  Widget _crearTextFieldPaterno() {
    return TextField(
      controller: _controllerPaterno,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: "Apellido Páterno",
          errorText: "Este campo es obligatorio"),
      onChanged: (value) {},
    );
  }

  Widget _crearTextFieldMaterno() {
    return TextField(
      controller: _controllerMaterno,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: "Apellido Materno",
          errorText: "Este campo es obligatorio"),
      onChanged: (value) {},
    );
  }

  Widget _crearTextFieldCorreo() {
    return TextField(
      controller: _controllerCorreo,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: "Correo electronico",
          errorText: "Este campo es obligatorio"),
      onChanged: (value) {},
    );
  }

  Widget _crearTextFieldTelefono() {
    return TextField(
      controller: _controllerTelefono,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: "Telefono",
          errorText: "Este campo es obligatorio"),
      onChanged: (value) {},
    );
  }
}
