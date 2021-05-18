import 'package:photo_diary/domain/calendar_key.dart';
import 'package:photo_diary/domain/diary.dart';

/*
  絵日記取得/保存インターフェイス
 */
class DiaryReadWriter {
  const DiaryReadWriter();

  Future<Diary> read({CalendarKey key}) {
    return Future
      .delayed(const Duration(seconds: 1))
      .then((_) {
        return Diary(image: "a", text: "b");
      });
  }
  Future<void> write({CalendarKey key, Diary diary}) {
    return Future
      .delayed(const Duration(seconds: 1))
      .then((_) {
        print("write Complete.");
        return;
      });
  }
}