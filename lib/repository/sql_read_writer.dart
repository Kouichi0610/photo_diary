import 'package:path_provider/path_provider.dart';
import 'package:photo_diary/domain/calendar_key.dart';
import 'package:photo_diary/domain/diary.dart';
import 'package:photo_diary/repository/diary_read_writer.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/*
  diarySample() async {
    var r = CreateDiaryReadWriter();
    await r.write(key: CalendarKey(DateTime(2001, 1, 1)), diary: Diary(image: "IMageA", text: "textB"));
    var d = await r.read(key: CalendarKey(DateTime(2000, 1, 1)));
  }
 */
class _Sqlite {
  _Sqlite._();
  static final _Sqlite instance = _Sqlite._();
  static Database _db = null;

  Future<Database> get database async {
    if (_db != null) return _db;
    _db = await _initDatabase();
    return _db;
  }

  Future<Database> _initDatabase() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    var path = join(documentsDirectory.path, "PhotoDiary.db");
    return await openDatabase(path, version: 1, onCreate: _createTable);
  }
  Future<void> _createTable(Database db, int version) async {
    return await db.execute(
        "CREATE TABLE Diary("
            "id INTEGER PRIMARY KEY,"
            "image TEXT,"
            "note TEXT"
            ")"
    );
  }
}

/*
  日記保存(sqlite)
*/
class SqlReadWriter implements DiaryReadWriter {
  final String _tableName = "Diary";

  Future<Diary> read({CalendarKey key}) async {
    var db = await _Sqlite.instance.database;
    var res = await db.query(_tableName);
    if (res.isEmpty) return Diary.none();

    var list = res.where((d) => d["id"] == key.key);
    if (list == null || list.length == 0) return Diary.none();

    return fromMap(list.first);
  }

  @override
  Future<void> write({CalendarKey key, Diary diary}) async {
    var db = await _Sqlite.instance.database;
    var res = await db.update(
      _tableName,
      toMap(key: key, diary: diary),
      where: "id = ?",
      whereArgs: [key.key]
      );
    // 上書きできなければ新規に追加
    if (res == 0) {
      // return id.
      await db.insert(_tableName, toMap(key: key, diary: diary));
    }
  }

  Diary fromMap(Map<String, dynamic> json) {
    return Diary(
      image: json["image"],
      text: json["note"]
    );
  }

  Map<String, dynamic> toMap({CalendarKey key, Diary diary}) => {
    "id": key.key,
    "image": diary.image,
    "note": diary.text
  };
}
