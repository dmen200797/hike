import 'package:hiker/main.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {//check nếu DB khác null thì return DB luôn
      return _database!;
    }
    _database = await initialize();//Khởi tạo DB
    return _database!;
  }

  Future<String> get fullPath async {
    const name = 'hike.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> initialize() async {
    final path = await fullPath;
    Database db = await openDatabase(
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
    ))''');
  }

  Future<int> createHike({
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
        '''INSERT INTO hikes (hikeName,country,city,date,hour,minute,length,difficulty,parking,description) VALUES (?,?,?,?,?,?,?,?,?,?)''',
        [
          hikeName,
          country,
          city,
          date.millisecondsSinceEpoch,
          hour,
          minute,
          length,
          difficulty,
          parking,
          description
        ]);
  }

  Future<List<HikeDetail>> getListHike() async {
    final db = await DatabaseService().database;
    final hikes = await db.rawQuery('SELECT * from hikes');
    return hikes.map((hike) => HikeDetail.fromSql(hike)).toList();
  }

  Future<int> update(HikeDetail hike) async {
    final db = await DatabaseService().database;
    return await db.update(
      'hikes',
      {
        "hikeName": hike.hikeName,
        "country": hike.country,
        "city": hike.city,
        "date": hike.date.millisecondsSinceEpoch,
        "hour": hike.hour,
        "minute": hike.minute,
        "length": hike.length,
        "difficulty": hike.difficulty,
        "parking": hike.parking,
        "description": hike.description,
      },
      where: 'id = ?',
      whereArgs: [hike.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await DatabaseService().database;
    await db.rawDelete('DELETE FROM hikes WHERE id = ?', [id]);
  }
}
