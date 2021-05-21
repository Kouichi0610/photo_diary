import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, EventList;
import 'package:photo_diary/domain/diary.dart';

typedef DayPressedCallback = void Function(DateTime day);

class Calendar extends StatefulWidget {
  final DayPressedCallback onDayPressed;
  final Map<DateTime, Diary> diaries;

  const Calendar(this.onDayPressed, this.diaries);

  @override
  State<StatefulWidget> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _current = DateTime.now();
  EventList<Event> _marked = EventList<Event>();

  @override
  void initState() {
    _marked = EventList<Event>();
    _marked.events = Map<DateTime, List<Event>>();

    widget.diaries.forEach((key, value) {
      _marked.add(
          key,
          Event(
            date: key,
            title: "",
            icon: Icon(Icons.article_outlined),
          )
      );
    });
  }

  void onDayPressed(DateTime date, List<Event> events) {
    widget.onDayPressed(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: CalendarCarousel<Event>(
        onDayPressed: onDayPressed,
        weekendTextStyle: TextStyle(color: Colors.red),
        thisMonthDayBorderColor: Colors.grey,
        weekFormat: false,
        selectedDateTime: _current,
        daysHaveCircularBorder: false,
        customGridViewPhysics: NeverScrollableScrollPhysics(),
        markedDatesMap: _marked,
        markedDateShowIcon: true,
        markedDateIconMaxShown: 1,
        locale: 'JA',
        todayTextStyle: TextStyle(
          color: Colors.blue,
        ),
        markedDateIconBuilder: (event) {
          return event.icon;
        },
        todayBorderColor: Colors.green,
        markedDateMoreShowTotal: false,
      ),
    );
  }
}
