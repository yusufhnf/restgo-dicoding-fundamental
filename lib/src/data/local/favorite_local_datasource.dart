import 'package:sqflite/sqflite.dart';

import '../model/restaurant_model.dart';

class FavoriteLocalDataSource {
  static late FavoriteLocalDataSource _instance;

  FavoriteLocalDataSource._createObject();

  static late Database _database;

  factory FavoriteLocalDataSource() {
    _instance = FavoriteLocalDataSource._createObject();
    return _instance;
  }

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  final String _tableFavoriteRestaurant = 'favourite_restaurant';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restaurant_db.db',
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableFavoriteRestaurant (
               id TEXT PRIMARY KEY,
               name TEXT, 
               city TEXT,
               pictureId TEXT,
               rating REAL
             )''',
        );
      },
      version: 1,
    );

    return db;
  }

  Future<void> insertFavoriteRestaurant(RestaurantModel restaurant) async {
    final Database db = await database;
    await db.insert(_tableFavoriteRestaurant, restaurant.toJsonSql());
  }

  Future<void> deleteFavoriteRestaurant(RestaurantModel restaurant) async {
    final db = await database;

    await db.delete(
      _tableFavoriteRestaurant,
      where: 'id = ?',
      whereArgs: [restaurant.id],
    );
  }

  Future<List<RestaurantModel>> getFavoriteRestaurant() async {
    final Database db = await database;
    List<Map<String, dynamic>> results =
        await db.query(_tableFavoriteRestaurant);

    List<RestaurantModel> listData = results.isNotEmpty
        ? results.map((item) => RestaurantModel.fromJson(item)).toList()
        : [];

    return listData;
  }

  Future<bool> checkFavoriteStatus(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results =
        await db.query(_tableFavoriteRestaurant);

    List<RestaurantModel> list =
        results.map((res) => RestaurantModel.fromJson(res)).toList();
    bool status = false;
    for (var i = 0; i < list.length; i++) {
      if (list[i].id == id) {
        return true;
      } else {
        status = false;
      }
    }
    return status;
  }
}
