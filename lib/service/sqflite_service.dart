
import 'package:multiply/model/list_model.dart';
import 'package:sqflite/sqflite.dart';

class SqfLiteService{
  Database? db;
  int versionCode = 1;
  String tableName = "list_table_name";

  String columnId = "id";
  String columnTitle = "title";
  String columnIsClicked = "is_clicked";

  SqfLiteService();

  Future<Database> getDb()async{
    if(db == null){
      db = await createDatabase();
      return db!;
    }
    return db!;
  }

  createDatabase()async{
    String directoryPath = await getDatabasesPath();
    String databasePath = "${directoryPath}list.db";
    var db = await openDatabase(databasePath, version: versionCode, onCreate:  populateDb);
    return db;
  }

  void populateDb(Database database, int version)async{
    await database.execute("CREATE TABLE IF NOT EXISTS $tableName("
        "$columnId INTEGER PRIMARY KEY AUTOINCREMENT,"
        "$columnTitle TEXT,"
        "$columnIsClicked INTEGER"
        ")");
  }

  Future addItem(ListModel listModel)async{
    Database db = await getDb();
    var id = await db.insert(tableName, listModel.toJson());
    print("Mind id: $id");
  }

  Future<List>getItems() async{
    Database db  = await getDb();
    var result = await db.query(tableName, columns: [columnId, columnTitle, columnIsClicked]);
    return result.toList();
  }

  Future updateItem(ListModel listModel)async{
    Database db = await getDb();
    var id = await db.update(tableName, listModel.toJson(), where: "$columnId = ?", whereArgs: [listModel.id]);
    print("Mind id: $id");
  }
  Future<void> deleteMind(int id)async{
    Database db = await getDb();
    await db.delete(tableName, where: "$columnId = ?", whereArgs: [id]);
  }

}