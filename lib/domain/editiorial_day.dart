
/*
  編集する日付
  02:00～01:59
  2021/05/18 01:59まで5/17扱いとする
 */
class EditiorialDay {
  String _day;

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
    var year = current.year;
    var month = current.month;
    var day = current.day;
    _day = "${year}年${month}月${day}日";
  }

  EditiorialDay.today() : this(DateTime.now());

  @override
  String toString() {
    return _day;
  }
}