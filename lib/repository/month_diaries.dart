import 'package:photo_diary/domain/calendar_key.dart';
import 'package:photo_diary/domain/diary.dart';
import 'factory.dart';

class MonthDiaries {
  final int year;
  final int month;
  MonthDiaries(this.year, this.month);

  Future<Map<DateTime, Diary>> diaries() async {
    var res = Map<DateTime, Diary>();
    var day = _firstDay();
    var key = CalendarKey(day);
    var lastKey = CalendarKey(_lastDay());
    var rp = CreateDiaryReadWriter();

    while(key.key != lastKey.key) {
      var diary = await rp.read(key: key);

      if (diary.empty() == false) {
        res[day] = diary;
      }

      day = day.add(Duration(days: 1));
      key = CalendarKey(day);
    }
    return res;
  }

  DateTime _firstDay() {
    var f = DateTime(year, month, 1);
    if (f.weekday != DateTime.sunday) {
      f = f.add(Duration(days: -f.weekday));
    }
    return f;
  }
  DateTime _lastDay() {
    var f = DateTime(year, month+1, 1).add(Duration(days: -1));
    if (f.weekday != DateTime.saturday) {
      f = f.add(Duration(days: (6 - f.weekday%7)));
    }
    return f;
  }
}
