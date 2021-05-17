
/*
  編集する日付
  02:00～01:59
  2021/05/18 01:59まで5/17扱いとする
 */
import 'package:photo_diary/domain/calendar_key.dart';

class EditiorialDay {
  int _year;
  int _month;
  int _day;

  CalendarKey toKey() => CalendarKey(DateTime(_year, _month, _day));

  DateTime _currentDay(DateTime now) {
    final DateTime limit = DateTime(now.year, now.month, now.day, 2);
    if (now.compareTo(limit) == -1) {
      final Duration d = Duration(days: -1);
      return now.add(d);
    }
    return now;
  }

  EditiorialDay(DateTime now) {
    var current = _currentDay(now);
    _year = current.year;
    _month = current.month;
    _day = current.day;
  }

  EditiorialDay.today() : this(DateTime.now());

  @override
  String toString() {
    return "${_year.toString()}年${_month.toString()}月${_day.toString()}日";
  }
}