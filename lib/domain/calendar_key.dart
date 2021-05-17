
/*
 */
class CalendarKey {
  int _key;

  int get key => _key;

  CalendarKey(DateTime now) {
    var y = now.year;
    var m = now.month;
    var d = now.day;
    _key = y * 10000 + m * 100 + d;
  }
}
