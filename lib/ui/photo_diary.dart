
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_diary/domain/diary.dart';

/*
  TODO:return Diary
 */
class PhotoDiary extends StatefulWidget {
  const PhotoDiary({Key key, this.title, this.editMode}) :super(key: key);

  final String title;
  final bool editMode;
  @override
  State<StatefulWidget> createState() => _PhotoDiaryState();
}

class _PhotoDiaryState extends State<PhotoDiary> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop(Diary.none());
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Column(
          children: [
            ElevatedButton(onPressed: () async {
              Navigator.pop(context, Diary(image: "imageA", text: "あああああああ"));
            },
            )
          ],
        ),
      ),
    );
  }
}
