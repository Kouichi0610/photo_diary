import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_diary/domain/diary.dart';

class DiaryEditor extends StatelessWidget {
  final String title;
  final Diary diary;
  final TextEditingController _textEditingController = TextEditingController();

  DiaryEditor(this.title, this.diary);

  Widget _diaryEditor() {
    return TextField(
      controller: _textEditingController,
      maxLines: 10,
      style: TextStyle(color: Colors.black),
      keyboardType: TextInputType.multiline,
    );
  }

  @override
  Widget build(BuildContext context) {
    _textEditingController.text = diary.text;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: _diaryEditor(),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "日記を作成",
        child: Icon(Icons.add_circle_outline_outlined),
        onPressed: () => _complete(context),
      ),
    );
  }

  void _complete(BuildContext context) {
    var next = Diary(image: diary.image, text: _textEditingController.text);
    print("Change:${next.toString()}");
    Navigator.of(context).pop(next);
  }
}
