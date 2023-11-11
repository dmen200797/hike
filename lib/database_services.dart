import 'package:hiker/main.dart';
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
    var db = openDatabase(
      path,
      version: 1,
      onCreate: create,
      singleInstance: true,
    );
    return db;
  }

  Future<void> create(Database database, int version) async =>
      await HikeDB().createTable(database);
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

  Future<int> create({
    required String hikeName,
    required String country,
    required String city,
    required DateTime date,
    required String hour,
    required String minute,
    required double length,
    required double difficulty,
    required String parking,
    required String description,
  }) async {
    final db = await DatabaseService().database;
    return await db.rawInsert(
        '''INSERT INTO hikes (hikeName,country,city,date,hour,minute,length,difficulty,parking,description) VALUE (?,?,?,?,?,?,?,?,?,?,)''',
        [hikeName,country,city,date.millisecondsSinceEpoch,hour,minute,length,difficulty,parking,description]);
  }

  Future<List<HikeDetail>> getListHike() async {
    final db = await DatabaseService().database;
    final hikes = await db.rawQuery(
      'SELECT * from hikes'
    );
    return hikes.map((hike) => HikeDetail.fromSql(hike)).toList();
  }
}
