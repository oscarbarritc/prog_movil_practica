import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:practica2/src/models/notas_model.dart';
import 'package:practica2/src/models/perfil_model.dart';
import 'package:practica2/src/models/tareas_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _nombreBD = "NOTASBD";
  static final _versionBD = 5;
  static final _nombreTBL = "tblNotas";
  static final _nombreTBLPerfil = "tblPerfil";
  static final _nombreTBLTarea = "tblTarea";
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    Directory carpeta = await getApplicationDocumentsDirectory();
    String rutaBD = join(carpeta.path, _nombreBD);
    return openDatabase(rutaBD,
        version: _versionBD, onCreate: createTable, onUpgrade: _onUpgrade);
  }

  Future<void> createTable(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $_nombreTBL (id INTEGER PRIMARY KEY,titulo VARCHAR(50),detalle VARCHAR(100))");
    await db.execute(
       "CREATE TABLE $_nombreTBLPerfil (id INTEGER PRIMARY KEY,nombre VARCHAR(50),a_paterno VARCHAR(50),a_materno VARCHAR(50),correo VARCHAR(50),telefono INTEGER)");
    await db.execute(
        "CREATE TABLE $_nombreTBLTarea (idTarea INTEGER PRIMARY KEY,nomTarea VARCHAR(50),dscTarea VARCHAR(1000),fechaEntrega text,entregada bit)");
  }

  Future<void> _onUpgrade(Database db, int oldversion, int newversion) async {
    await db.execute(
        "CREATE TABLE $_nombreTBLTarea (idTarea INTEGER PRIMARY KEY,nomTarea VARCHAR(50),dscTarea VARCHAR(1000),fechaEntrega text,entregada bit)");
  }

  Future<int> insert(Map<String, dynamic> row) async {
    var conexion = await database;
    return conexion!.insert(_nombreTBL, row);
  }

  Future<int> update(Map<String, dynamic> row) async {
    var conexion = await database;
    return conexion!
        .update(_nombreTBL, row, where: 'id = ?', whereArgs: [row['id']]);
  }

  Future<int> delete(int id) async {
    var conexion = await database;
    return conexion!.delete(_nombreTBL, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<NotasModel>> getAllnotes() async {
    var conexion = await database;
    var result = await conexion!.query(_nombreTBL);
    return result.map((notaMap) => NotasModel.fromMap(notaMap)).toList();
  }

  Future<NotasModel> getNote(int id) async {
    var conexion = await database;
    var result =
        await conexion!.query(_nombreTBL, where: 'id = ?', whereArgs: [id]);
    //result.map((notaMap) => NotasModel.fromMap(notaMap)).first;
    return NotasModel.fromMap(result.first);
  }

  Future<int> insertuser(Map<String, dynamic> row) async {
    var conexion = await database;
    print("object1");
    return conexion!.insert(_nombreTBLPerfil, row);
  }

  Future<int> updateuser(Map<String, dynamic> row) async {
    var conexion = await database;
    return conexion!.update(_nombreTBLPerfil, row, where: 'id = ?', whereArgs: [row['id']]);
  }

  Future<List<PerfilModel>> getAllnperfil() async {
    var conexion = await database;
    var result = await conexion!.query(_nombreTBLPerfil);
    return result.map((userMap) => PerfilModel.fromMap(userMap)).toList();
  }

  Future<PerfilModel> getuser() async {
    int id = 1;
    var conexion = await database;
    var result = await conexion!
        .query(_nombreTBLPerfil, where: 'id = ?', whereArgs: [id]);
    //result.map((notaMap) => NotasModel.fromMap(notaMap)).first;
    return PerfilModel.fromMap(result.first);
  }

//tareas
  Future<int> inserttarea(Map<String, dynamic> row) async {
    var conexion = await database;
    return conexion!.insert(_nombreTBLTarea, row);
  }

  Future<int> updatetarea(Map<String, dynamic> row) async {
    var conexion = await database;
    return conexion!
        .update(_nombreTBLTarea, row, where: 'idTarea = ?', whereArgs: [row['idTarea']]);
  }

  Future<int> deletetarea(int id) async {
    var conexion = await database;
    return conexion!.delete(_nombreTBLTarea, where: 'idTarea = ?', whereArgs: [id]);
  }

  Future<List<TareasModel>> getAlltareas() async {
    var conexion = await database;
    var result = await conexion!.query(_nombreTBLTarea,where: 'entregada = ?', whereArgs: [0]);
    return result.map((tareaMap) => TareasModel.fromMap(tareaMap)).toList();
  }
  Future<List<TareasModel>> getAlltareasEntregadas() async {
    var conexion = await database;
    var result = await conexion!.query(_nombreTBLTarea,where: 'entregada = ?', whereArgs: [1]);
    return result.map((tareaMap) => TareasModel.fromMap(tareaMap)).toList();
  }

  Future<TareasModel> gettarea(int id) async {
    var conexion = await database;
    var result =
        await conexion!.query(_nombreTBLTarea, where: 'idTarea = ?', whereArgs: [id]);
    //result.map((notaMap) => NotasModel.fromMap(notaMap)).first;
    return TareasModel.fromMap(result.first);
  }


//fin
}
