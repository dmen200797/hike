import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    const name = 'hike.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> initialize() async {
    final path = await fullPath;
    var database = openDatabase(
      path,
      version: 1,
      onCreate: create,
      singleInstance: true,
    );
    return database;
  }

  Future<void> create(Database database, int version) async => await HikeDB().createTable(database);
}

class HikeDB {
  Future<void> createTable(Database database) async {
    await database.execute('''CREATE TABLE IF NOT EXISTS hikes (
    "id" INTEGER NOT NULL,
    "hikeName" TEXT,
    "country" TEXT,
    "city" TEXT,
    "date" TEXT,
    "hour" TEXT,
    "minute" TEXT,
    "length" REAL,
    "difficulty" REAL,
    "parking" TEXT,
    "description" TEXT,
    PRIMARY KEY("id" AUTOINCREMENT
    )''');
  }
}
