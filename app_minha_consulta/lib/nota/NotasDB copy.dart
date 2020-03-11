import "package:path/path.dart";
import "package:sqflite/sqflite.dart";
import "../utils.dart" as utils;
import "NotasModel.dart";

/// ********************************************************************************************************************
/// Database provider class for notas.
/// ********************************************************************************************************************
class NotasDB {
  /// Static instance and private constructor, since this is a singleton.
  NotasDB._();
  static final NotasDB db = NotasDB._();

  /// The one and only database instance.
  Database _db;

  /// Get singleton instance, create if not available yet.
  ///
  /// @return The one and only Database instance.
  Future get database async {
    try {
      if (_db == null) {
        print("##120 ERRO _db: null");
        _db = await init();
      }
      print("##45 Notas NotasDB.get-database(): _db = $_db");
      return _db;
    } catch (e) {
      print("##46 ERRO get-database(): $e ");
    }
  } /* End database getter. */

  /// Initialize database.
  ///
  /// @return A Database instance.
  Future<Database> init() async {
    print("Notas NotasDB.init()");

    String path = join(utils.docsDir.path, "notas.db");
    print("##47 notas NotasDB.init(): path = $path");
    Database db = await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database inDB, int inVersion) async {
      await inDB.execute("CREATE TABLE IF NOT EXISTS notas ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "content TEXT,"
          "color TEXT"
          ")");
    });
    return db;
  } /* End init(). */

  /// Create a Nota from a Map.
  Nota notaFromMap(Map inMap) {
    print("##48 Notas NotasDB.notaFromMap(): inMap = $inMap");

    Nota nota = Nota();
    nota.id = inMap["id"];
    nota.title = inMap["title"];
    nota.content = inMap["content"];
    nota.color = inMap["color"];

    print("##49 Notas NotasDB.notaFromMap(): nota = $nota");

    return nota;
  } /* End notaFromMap(); */

  /// Create a Map from a Nota.
  Map<String, dynamic> notaToMap(Nota inNota) {
    print("##50 Notas NotasDB.notaToMap(): inNota = $inNota");

    Map<String, dynamic> map = Map<String, dynamic>();
    map["id"] = inNota.id;
    map["title"] = inNota.title;
    map["content"] = inNota.content;
    map["color"] = inNota.color;
    print("##51 notas NotasDB.notaToMap(): map = $map");
    return map;
  } /* End notaToMap(). */

  /// Create a nota.
  ///
  /// @param  inNota The Nota object to create.
  /// @return        Future.
  Future create(Nota inNota) async {
    print("##52 Notas NotasDB.create(): inNota = $inNota");

    Database db = await database;

    // Get largest current id in the table, plus one, to be the new ID.
    var val = await db.rawQuery("SELECT MAX(id) + 1 AS id FROM notas");
    int id = val.first["id"];
    if (id == null) {
      id = 1;
    }

    // Insert into table.
    return await db.rawInsert(
        "INSERT INTO notas (id, title, content, color) VALUES (?, ?, ?, ?)",
        [id, inNota.title, inNota.content, inNota.color]);
  } /* End create(). */

  /// Get a specific nota.
  ///
  /// @param  inID The ID of the nota to get.
  /// @return      The corresponding Nota object.
  Future<Nota> get(int inID) async {
    print("##53 Notas NotasDB.get(): inID = $inID");

    Database db = await database;
    var rec = await db.query("notas", where: "id = ?", whereArgs: [inID]);

    print("##54 Notas NotasDB.get(): rec.first = $rec.first");

    return notaFromMap(rec.first);
  } /* End get(). */

  /// Get all notas.
  ///
  /// @return A List of Nota objects.
  Future<List> get getAll async {
    print("##55 Notas NotasDB.getAll()");
    try {
      Database db = await database;
      var recs = await db.query("notas");
      var list =
          recs.isNotEmpty ? recs.map((m) => notaFromMap(m)).toList() : [];

      print("##56 Notas NotasDB.getAll(): list = $list");

      return list;
    } catch (e) {
      print("##57 ERRO getAll(): $e ");
      return null;
    }
  } /* End getAll(). */

  /// Update a nota.
  ///
  /// @param inNota The nota to update.
  /// @return       Future.
  Future update(Nota inNota) async {
    print("##58 Notas NotasDB.update(): inNota = $inNota");
    try {
      Database db = await database;
      return await db.update("notas", notaToMap(inNota),
          where: "id = ?", whereArgs: [inNota.id]);
    } catch (e) {
      print("##59 ERRO NotasDB.update(): $e ");
    }
  } /* End update(). */

  /// Delete a nota.
  ///
  /// @param inID The ID of the nota to delete.
  /// @return     Future.
  Future delete(int inID) async {
    print("##60 Notas NotasDB.delete(): inID = $inID");
    try {
      Database db = await database;
      return await db.delete("notas", where: "id = ?", whereArgs: [inID]);
    } catch (e) {
      print("##61 ERRO NotasDB.delete(): $e ");
    }
  } /* End delete(). */
} /* End class. */
