import 'package:photo_diary/domain/calendar_key.dart';
import 'package:photo_diary/domain/diary.dart';
import 'package:photo_diary/repository/diary_read_writer.dart';

/*
  Web版対応DiaryReadWriter
  永続化は考慮に入れてない
 */
class LocalReadWriter implements DiaryReadWriter {
  static Map<int, Diary> _diaries = Map<int, Diary>();

  @override
  Future<Diary> read({CalendarKey key}) {
    return Future.sync(() {
      var res = _diaries[key.key];
      if (res == null) return Diary.none();
      return res;
    });
  }

  @override
  Future<void> write({CalendarKey key, Diary diary}) {
    return Future.sync(() => _diaries[key.key] = diary);
  }
}
