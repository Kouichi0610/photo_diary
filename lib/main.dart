import 'package:flutter/material.dart';
import 'package:photo_diary/domain/editiorial_day.dart';
import 'package:photo_diary/ui/calendar.dart';

import 'domain/calendar_key.dart';

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  String _editTitle() {
    var e = EditiorialDay.today();
    return "${e.toString()}の日記を書く";
  }

  void dayPressed(CalendarKey key) {
    print("DayPressed:${key.key}");
  }

  @override
  Widget build(BuildContext context) {
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
        onPressed: _incrementCounter,
        tooltip: _editTitle(),
        child: Icon(Icons.add),
      ),
    );
  }
}
