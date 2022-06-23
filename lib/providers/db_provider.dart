import 'package:path_provider/path_provider.dart';
import 'package:qr_scanner/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'dart:io';

class DbProvider {
  static Database? _database;

  //Instance of the singleton DbProvider as static
  static final DbProvider db = DbProvider._();
  DbProvider._();

  //First time es create a new DbProvider or call the instance of the constructor

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    //Inicialize the Db if doesn't exist'
    _database = await initDb();
    return _database;
  }

  //Init the database only once
  Future<Database> initDb() async {
    //Path to almacenate
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'qr_scanner.db');
    print(path);

    //create the database
    return await openDatabase(
      path,
      version: 1, // update the version always you configure the database
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          );
        ''');
      },
    );
  }

  Future<int> newScanRaw(ScanModel newScan) async {
    final id = newScan.id;
    final tipo = newScan.tipo;
    final valor = newScan.valor;

    //get reference to db
    final db = await database;
    //query database
    final res = await db!.rawInsert(''''
      INSERT INTO Scans(id, tipo, valor)
        VALUES($id, '$tipo', '$valor')
    ''');
    return res;
  }

  Future<int> newScan(ScanModel newScan) async {
    final db = await database;
    final res = await db!.insert('Scans', newScan.toJson());
    print(res);
    return res;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db!.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>?> getWholeScans() async {
    final db = await database;
    final res = await db!.query('Scans');

    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future<List<ScanModel>?> getScansByType(String type) async {
    final db = await database;
    final res = await db!.rawQuery('''
  
      SELECT * FROM Scans WHERE tipo = "$type"
    
    
    ''');

    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future<int?> updateScan(ScanModel newUpdate) async {
    final db = await database;
    final res = await db?.update('Scans', newUpdate.toJson(),
        where: 'id = ?', whereArgs: [newUpdate.id]);

    return res;
  }

  Future<int?> deleteScan(int? id) async {
    final db = await database;
    final res = await db?.delete('Scans', where: 'id =?', whereArgs: [id]);
    return res;
  }

  Future<int?> deleteAllScans() async {
    final db = await database;
    final res = await db?.delete('Scans');
    return res;
  }

  deleteScanById(int id) {}
}
