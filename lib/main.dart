import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, EventList;
import 'package:photo_diary/domain/editiorial_day.dart';
import 'package:photo_diary/repository/factory.dart';
import 'package:photo_diary/repository/month_diaries.dart';
import 'package:photo_diary/ui/diary_event.dart';
import 'package:photo_diary/ui/photo_selector.dart';
import 'package:photo_diary/ui/view_diary.dart';

import 'domain/calendar_key.dart';
import 'domain/diary.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'photo_diary',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '写真絵日記'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _year;
  int _month;
  EventList<DiaryEvent> _diaries = EventList<DiaryEvent>();

  _MyHomePageState() {
    var now = DateTime.now();
    _year = now.year;
    _month = now.month;
    _diaries = EventList<DiaryEvent>();
    _diaries.events = Map<DateTime, List<DiaryEvent>>();
  }

  @override
  void initState() {
    _setMarkers();
  }

  void _setMarkers() async {
    var diaries = await _monthDiaries();
    setState(() {
      _diaries.clear();
      diaries.forEach((key, value) {
        _diaries.add(key, DiaryEvent(key, value));
      });
    });
  }

  String _toTitle(DateTime now) {
    return "${now.year}年${now.month}月${now.day}日";
  }

  void _addDiary() async {
    var key = CalendarKey(DateTime.now());
    var rp = CreateDiaryReadWriter();
    var prev = await rp.read(key: key);

    Diary next = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return PhotoSelector(_toTitle(DateTime.now()), prev);
      }),
    );
    // 変更なし
    if (next.equals(prev)) return;

    // 追加、更新
    await rp.write(key: key, diary: next);
    await _setMarkers();
  }

  void _dayPressed(DateTime day, List<DiaryEvent> events) async {
    if (events.length == 0) return;

    var title = events[0].getTitle();
    var diary = events[0].diary;

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return ViewDiary(title, diary);
      }),
    );
  }

  Future<Map<DateTime, Diary>> _monthDiaries() async {
    var md = MonthDiaries(_year, _month);
    return await md.diaries();
  }

  void _calendarChanged(DateTime day) async {
    _year = day.year;
    _month = day.month;
    await _setMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: CalendarWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addDiary,
        tooltip: _editTitle(),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget CalendarWidget() {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: CalendarCarousel<DiaryEvent>(
        onDayPressed: _dayPressed,
        onCalendarChanged: _calendarChanged,
        weekendTextStyle: TextStyle(color: Colors.red),
        thisMonthDayBorderColor: Colors.grey,
        weekFormat: false,
        daysHaveCircularBorder: false,
        customGridViewPhysics: NeverScrollableScrollPhysics(),
        markedDatesMap: _diaries,
        markedDateShowIcon: true,
        markedDateIconMaxShown: 1,
        locale: 'JA',
        todayTextStyle: TextStyle(
          color: Colors.blue,
        ),
        markedDateIconBuilder: (event) => event.getIcon(),
        todayBorderColor: Colors.green,
        markedDateMoreShowTotal: false,
      ),
    );
  }

  String _editTitle() {
    var e = EditiorialDay.today();
    return "${e.toString()}の日記を書く";
  }
}
