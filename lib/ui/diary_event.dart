import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter/material.dart';
import 'package:photo_diary/domain/diary.dart';

class DiaryEvent implements EventInterface {
  final Diary diary;
  final DateTime date;
  const DiaryEvent(this.date, this.diary);

  @override
  DateTime getDate() {
    return date;
  }

  @override
  Widget getDot() {
    return Center();
  }

  @override
  Widget getIcon() {
    return Icon(
      Icons.article_outlined,
      color: Color.fromRGBO(0, 0, 0, 0.5),
    );
  }

  @override
  int getId() {
    return 1;
  }

  @override
  String getTitle() {
    return "${date.year}/${date.month}${date.day}の日記";
  }
}
