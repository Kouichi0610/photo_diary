import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, EventList;

typedef DayPressedCallback = void Function(DateTime day);

class Calendar extends StatefulWidget {
  DayPressedCallback onDayPressed;

  Calendar({DayPressedCallback dayPressed}) {
    onDayPressed = dayPressed;
  }

  @override
  State<StatefulWidget> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _current = DateTime.now();
  EventList<Event> _marked = EventList<Event>();

  _CalendarState() {
    _marked = EventList<Event>();
    _marked.events = Map<DateTime, List<Event>>();
  }

  void onDayPressed(DateTime date, List<Event> events) {
    this.setState(() {
    });
    widget.onDayPressed(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: CalendarCarousel<Event>(
        onDayPressed: onDayPressed,
        childAspectRatio: 1.6,
        weekendTextStyle: TextStyle(color: Colors.red),
        thisMonthDayBorderColor: Colors.grey,
        weekFormat: false,
        height: 580,
        selectedDateTime: _current,
        daysHaveCircularBorder: false,
        customGridViewPhysics: NeverScrollableScrollPhysics(),
        markedDatesMap: _marked,
        //markedDateWidget: Image.asset("images/glass.png"),
        markedDateShowIcon: true,
        markedDateIconMaxShown: 2,
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
