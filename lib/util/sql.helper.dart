import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""
     CREATE TABLE vivencias (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        fecha DATETIME,
        descripcion TEXT,
        photo TEXT
     )
     """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase("war.db", version: 3,
        onCreate: (sql.Database database, int version) async {
      await createTable(database);
    });
  }

  static Future<int> createVivencia(String title, DateTime fecha,
      String descripcion, String photo) async {
    final db = await SQLHelper.db();

    final data = {
      'title': title,
      'fecha':  fecha.toUtc().toIso8601String(),
      'descripcion': descripcion,
      'photo': photo,
    };

    final id = await db.insert('vivencias', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return id;
  }

  static Future<List<Map<String, dynamic>>> getVivencias() async {
    final db = await SQLHelper.db();
    return db.query('vivencias');
  }

  static Future<void> deleteAllVivencias() async {
    final db = await SQLHelper.db();
    await db.delete('vivencias');
  }
}
