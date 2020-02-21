import "package:path/path.dart";
import "package:sqflite/sqflite.dart";
import "../utils.dart" as utils;
import "Anotacoes_Model.dart";


/// ********************************************************************************************************************
/// Database provider class for anotacoes.
/// ********************************************************************************************************************
class AnotacoesDBWorker {


  /// Static instance and private constructor, since this is a singleton.
  AnotacoesDBWorker._();
  static final AnotacoesDBWorker db = AnotacoesDBWorker._();


  /// The one and only database instance.
  Database _db;


  /// Get singleton instance, create if not available yet.
  ///
  /// @return The one and only Database instance.
  Future get database async {
    try{
if (_db == null) {
      print("##120 ERRO _db: null");
      _db = await init();
    }
    print("##121 anotacoes AnotacoesDBWorker.get-database(): _db = $_db");
    return _db;
    }catch(e){
      print("##122 ERRO _db: try_catch($e)");
    }

    

  } /* End database getter. */


  /// Initialize database.
  ///
  /// @return A Database instance.
  Future<Database> init() async {

    String path = join(utils.docsDir.path, "anotacoes.db");
    print("##123 anotacoes AnotacoesDBWorker.init(): path = $path");
    Database db = await openDatabase(path, version : 1, onOpen : (db) { },
      onCreate : (Database inDB, int inVersion) async {
        await inDB.execute(
          "CREATE TABLE IF NOT EXISTS anotacoes ("
            "id INTEGER PRIMARY KEY,"
            "title TEXT,"
            "description TEXT,"
            "apptDate TEXT,"
            "apptTime TEXT"
          ")"
        );
      }
    );
    return db;

  } /* End init(). */


  /// Create a Anotacoes from a Map.
  Anotacoes anotacoesFromMap(Map inMap) {

    print("##124 anotacoes AnotacoesDBWorker.anotacoesFromMap(): inMap = $inMap");
    Anotacoes anotacoes = Anotacoes();
    anotacoes.id = inMap["id"];
    anotacoes.title = inMap["title"];
    anotacoes.description = inMap["description"];
    anotacoes.apptDate = inMap["apptDate"];
    anotacoes.apptTime = inMap["apptTime"];
    print("##125 anotacoes AnotacoesDBWorker.anotacoesFromMap(): anotacoes = $anotacoes");

    return anotacoes;

  } /* End anotacoesFromMap(); */


  /// Create a Map from a Anotacoes.
  Map<String, dynamic> anotacoesToMap(Anotacoes inAnotacoes) {

    print("##126 anotacoes AnotacoesDBWorker.anotacoesToMap(): inAnotacoes = $inAnotacoes");
    Map<String, dynamic> map = Map<String, dynamic>();
    map["id"] = inAnotacoes.id;
    map["title"] = inAnotacoes.title;
    map["description"] = inAnotacoes.description;
    map["apptDate"] = inAnotacoes.apptDate;
    map["apptTime"] = inAnotacoes.apptTime;
    print("##127 anotacoes AnotacoesDBWorker.anotacoesToMap(): map = $map");

    return map;

  } /* End anotacoesToMap(). */


  /// Create a anotacoes.
  ///
  /// @param inAnotacoes the Anotacoes object to create.
  Future create(Anotacoes inAnotacoes) async {

    print("##128 anotacoes AnotacoesDBWorker.create(): inAnotacoes = $inAnotacoes");

    Database db = await database;

    // Get largest current id in the table, plus one, to be the new ID.
    var val = await db.rawQuery("SELECT MAX(id) + 1 AS id FROM anotacoes");
    int id = val.first["id"];
    if (id == null) { id = 1; }

    // Insert into table.
    return await db.rawInsert(
      "INSERT INTO anotacoes (id, title, description, apptDate, apptTime) VALUES (?, ?, ?, ?, ?)",
      [
        id,
        inAnotacoes.title,
        inAnotacoes.description,
        inAnotacoes.apptDate,
        inAnotacoes.apptTime
      ]
    );

  } /* End create(). */


  /// Get a specific anotacoes.
  ///
  /// @param  inID The ID of the anotacoes to get.
  /// @return      The corresponding Anotacoes object.
  Future<Anotacoes> get(int inID) async {

    print("##129 anotacoes AnotacoesDBWorker.get(): inID = $inID");

    Database db = await database;
    var rec = await db.query("anotacoes", where : "id = ?", whereArgs : [ inID ]);
    print("##130 anotacoes AnotacoesDBWorker.get(): rec.first = $rec.first");
    return anotacoesFromMap(rec.first);

  } /* End get(). */


  /// Get all anotacoes.
  ///
  /// @return A List of Anotacoes objects.
  Future<List> getAll() async {
    try{
      Database db = await database;
      var recs = await db.query("anotacoes");
      var list = recs.isNotEmpty ? recs.map((m) => anotacoesFromMap(m)).toList() : [ ];
      print("##131 anotacoes AnotacoesDBWorker.getAll(): list = $list");
      return list;
    }catch(e){
      print("##132 ERRO getAll(): $e ");
      return null;
    }
  } /* End getAll(). */


  /// Update a anotacoes.
  ///
  /// @param inAnotacoes The anotacoes to update.
  Future update(Anotacoes inAnotacoes) async {

    print("##133 anotacoes AnotacoesDBWorker.update(): inAnotacoes = $inAnotacoes");

    Database db = await database;
    return await db.update(
      "anotacoes", anotacoesToMap(inAnotacoes), where : "id = ?", whereArgs : [ inAnotacoes.id ]
    );

  } /* End update(). */


  /// Delete a anotacoes.
  ///
  /// @param inID The ID of the anotacoes to delete.
  Future delete(int inID) async {

    print("##134 anotacoes AnotacoesDBWorker.delete(): inID = $inID");

    Database db = await database;
    return await db.delete("anotacoes", where : "id = ?", whereArgs : [ inID ]);

  } /* End delete(). */


} /* End class. */