import 'package:photo_diary/domain/calendar_key.dart';
import 'package:photo_diary/repository/diary_read_writer.dart';
import 'package:test/test.dart';

void main() {
  test('DiaryReadWriter', () async {
    DiaryReadWriter r = DiaryReadWriter();
    var key = CalendarKey(DateTime.now());

    await r.read(key:key)
      .then((value) {
        expect(value.empty(), false);
      });
  });
}
