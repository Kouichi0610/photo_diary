import 'package:flutter/material.dart';
import 'package:photo_diary/domain/editiorial_day.dart';
import 'package:photo_diary/repository/factory.dart';
import 'package:photo_diary/repository/month_diaries.dart';
import 'package:photo_diary/ui/calendar.dart';
import 'package:photo_diary/ui/photo_diary.dart';
import 'package:photo_diary/ui/photo_selector.dart';

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

  _MyHomePageState() {
    var now = DateTime.now();
    _year = now.year;
    _month = now.month;
  }

  String _toTitle(DateTime now) {
    return "${now.year}年${now.month}月${now.day}日";
  }

  void _addDiary() async {
    var key = CalendarKey(DateTime.now());
    var rp = CreateDiaryReadWriter();
    var prev = await rp.read(key: key);
    print("Prev:${prev.toString()}");

    Diary next = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return PhotoSelector(_toTitle(DateTime.now()), prev);
      }),
    );

    // 変更なし
    if (next.equals(prev)) return;

    await rp.write(key: key, diary: next);
    /*
    setState(() {
    });
     */
  }

  String _editTitle() {
    var e = EditiorialDay.today();
    return "${e.toString()}の日記を書く";
  }

  void _dayPressed(DateTime day) async {
    if (true) return;
    Diary res = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return PhotoDiary(title: _toTitle(day), editMode: false);
      }),
    );
    print("Result:${res.toString()}");
    setState(() {
    });
  }

  Future<Map<DateTime, Diary>> _monthDiaries() async {
    var md = MonthDiaries(_year, _month);
    return await md.diaries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          future: _monthDiaries(),
          builder: (BuildContext context, AsyncSnapshot<Map<DateTime, Diary>> snapShot) {
            if (!snapShot.hasData || snapShot.connectionState != ConnectionState.done) {
              return CircularProgressIndicator();
            }
            return Calendar(_dayPressed, snapShot.data);
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addDiary,
        tooltip: _editTitle(),
        child: Icon(Icons.add),
      ),
    );
  }
}
