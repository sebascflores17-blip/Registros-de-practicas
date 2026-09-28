import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../features/practicas/data/registro_practica.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('practicas.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE registros (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        estudianteId TEXT NOT NULL,
        empresaNombre TEXT NOT NULL,
        actividad TEXT NOT NULL,
        fecha TEXT NOT NULL,
        horasCumplidas REAL NOT NULL,
        observacionSupervisor TEXT,
        estado TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertRegistro(RegistroPractica registro) async {
    final db = await instance.database;
    return await db.insert('registros', registro.toMap());
  }

  Future<List<RegistroPractica>> getRegistros() async {
    final db = await instance.database;
    final result = await db.query('registros', orderBy: 'id DESC');
    return result.map((json) => RegistroPractica.fromMap(json)).toList();
  }

  Future<int> updateRegistro(RegistroPractica registro) async {
    final db = await instance.database;
    return await db.update(
      'registros',
      registro.toMap(),
      where: 'id = ?',
      whereArgs: [registro.id],
    );
  }

  Future<int> deleteRegistro(int id) async {
    final db = await instance.database;
    return await db.delete('registros', where: 'id = ?', whereArgs: [id]);
  }
}
