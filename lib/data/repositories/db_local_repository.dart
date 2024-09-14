import 'package:distribucion_app/data/models/client_model.dart';
import 'package:distribucion_app/data/models/distribution_model.dart';
import 'package:distribucion_app/domain/entities/client.dart';
import 'package:distribucion_app/domain/entities/distribution.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' show join;

import 'package:sqflite/sqflite.dart';

class LocalDatabaseRepository {
  static Database? _database;
  static final LocalDatabaseRepository db = LocalDatabaseRepository._();
  LocalDatabaseRepository._();

  LocalDatabaseRepository();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    var directory = await getDatabasesPath();
    final path = join(directory, 'distribution.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (db, version) async {
        await db.execute('''
            CREATE TABLE distribution(
              id TEXT,
              date TEXT,
              clientName TEXT,
              clientCode INTEGER,
              idClient TEXT,
              cartons INTEGER,
              discounts INTEGER,
              typePay TEXT,
              observations TEXT
            );
        ''');
        await db.execute('''
            CREATE TABLE totalDistribution(
              idDistribution TEXT PRIMARY KEY,
              warehouseExit INTEGER, 
              avalaibleRote INTEGER, 
              difference INTEGER,
              disposal INTEGER,
              total INTEGER
            );
        ''');
        await db.execute('''
            CREATE TABLE client(
              idClient TEXT PRIMARY KEY,
              name TEXT,
              code INTEGER
            );
        ''');
      },
    );
  }

  Future<Client> newClient(Client newClient) async {
    final clientModel = ClientModel.fromEntity(newClient);

    final db = await database;
    final id = await db.insert('client', clientModel.toJson());

    if (id == 0) {
      throw Exception('Error al insertar el cliente');
    }

    return newClient;
  }

  Future<List<Client>> getAllClients() async {
    final db = await database;
    final res = await db.query('client');
    return res.map((e) => ClientModel.fromJson(e).toEntity()).toList();
  }

  Future<int> deleteClient(String id) async {
    final db = await database;
    return await db.delete('client', where: 'idClient = ?', whereArgs: [id]);
  }

  Future<int> newDistribution(List<Distribution> distributions) async {
    final exists = await getAllDistributionByDate(distributions.first.date);

    if (exists.isEmpty) {
      return await addNewDistribution(distributions);
    }

    return await updateDistribution(distributions);
  }

  Future<List<Distribution>> getAllDistributionByDate(DateTime date) async {
    final db = await database;

    final res = await db.query(
      'distribution',
      where: 'date = ?',
      whereArgs: [DateFormat('yyyy-MM-dd').format(date)],
    );
    return res.map((s) => DistributionModel.fromJson(s).toEntity()).toList();
  }

  Future<int> addNewDistribution(List<Distribution> distributions) async {
    final db = await database;
    final batch = db.batch();
    for (var distribution in distributions) {
      final data = [
        distribution.id,
        DateFormat('yyyy-MM-dd').format(distribution.date),
        distribution.clientName,
        distribution.clientCode,
        distribution.idClient,
        distribution.cartons,
        distribution.discounts,
        distribution.typePay,
        distribution.observations,
      ];
      batch.rawInsert('''
      INSERT INTO distribution(
        id, 
        date, 
        clientName, 
        clientCode, 
        idClient, 
        cartons, 
        discounts, 
        typePay, 
        observations
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    ''', data);
    }
    final results = await batch.commit();
    return results.length; // return the total commits created
  }

  Future<int> updateDistribution(List<Distribution> distributions) async {
    final db = await database;
    final batch = db.batch();
    for (var distribution in distributions) {
      batch.rawUpdate('''
      UPDATE distribution SET 
        date = ?, 
        clientName = ?, 
        clientCode = ?,
        idClient = ?,
        cartons = ?,
        discounts = ?,
        typePay = ?,
        observations = ? 
      WHERE id = ? AND clientName = ?
    ''', [
        DateFormat('yyyy-MM-dd').format(distribution.date),
        distribution.clientName,
        distribution.clientCode,
        distribution.idClient,
        distribution.cartons,
        distribution.discounts,
        distribution.typePay,
        distribution.observations,
        distribution.id,
        distribution.clientName,
      ]);
    }
    final results = await batch.commit();
    return results.length; // return the total commits created
  }
}
