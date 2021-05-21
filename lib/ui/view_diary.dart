import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_diary/domain/diary.dart';
import 'package:photo_diary/ui/photo_image.dart';

class ViewDiary extends StatelessWidget {
  final String title;
  final Diary diary;
  const ViewDiary(this.title, this.diary);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: height/3,
              child: PhotoImage(File(diary.image)),
            ),
            Container(
              height: height/3,
              child: Text(
                diary.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
