import 'package:filmfan/models/favorite_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

class DbHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }

    _db = await initDatabase();
  }

  initDatabase() async {
    io.Directory documentDirectoty = await getApplicationDocumentsDirectory();

    String path = join(documentDirectoty.path, 'myfavorite.db');
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE myfavorite (id INTEGER PRIMARY KEY, movieId VARCHAR UNIQUE,movieName TEXT ,moviePoster TEXT, movieRate VARCHAR)');
  }

  Future<MyFavorite> insert(MyFavorite favorite) async {
    var dbClient = await db;
    await dbClient!.insert('myfavorite', favorite.toJson());
    return favorite;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('myfavorite', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient!.delete('myfavorite');
  }

  Future<List<MyFavorite>> getMyFavoriteList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
    await dbClient!.query('myfavorite');
    return queryResult.map((e) => MyFavorite.fromJson(e)).toList();
  }
}
