import 'package:photo_diary/domain/editiorial_day.dart';
import 'package:test/test.dart';

void main() {
  test('今日の日付取得', () {
    final Map<DateTime, String> expects = {
      DateTime(2021, 3, 1, 0, 0, 0) : "2021年2月28日",
      DateTime(2021, 3, 1, 1, 0, 0) : "2021年2月28日",
      DateTime(2021, 3, 1, 1, 59, 59) : "2021年2月28日",
      DateTime(2021, 3, 1, 2, 0, 0) : "2021年3月1日",
    };

    expects.forEach((now, value) {
      var actual = EditiorialDay(now);
      expect(actual.toString(), value);
    });
  });
}
