import 'package:flutter/material.dart';
import 'package:photo_diary/domain/editiorial_day.dart';
import 'package:photo_diary/ui/calendar.dart';
import 'package:photo_diary/ui/photo_diary.dart';

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

  String _toTitle(DateTime now) {
    return "${now.year}年${now.month}月${now.day}日";
  }

  void _addDiary() async {
    Diary res = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return PhotoDiary(title: _toTitle(DateTime.now()), editMode: true);
      }),
    );
    print("Result:${res.toString()}");
    setState(() {
    });
  }

  String _editTitle() {
    var e = EditiorialDay.today();
    return "${e.toString()}の日記を書く";
  }

  void dayPressed(DateTime day) async {
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

  @override
  Widget build(BuildContext context) {
    print("ReBuild.");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Calendar(
          dayPressed: dayPressed,
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
