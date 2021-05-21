import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_diary/domain/diary.dart';
import 'package:photo_diary/ui/photo_image.dart';

import 'diary_editor.dart';

/*
  写真選択画面
 */
class PhotoSelector extends StatefulWidget {
  final Diary diary;
  final String title;
  const PhotoSelector(this.title, this.diary);
  @override
  State<StatefulWidget> createState() => _PhotoSelectorState(diary);
}

class _PhotoSelectorState extends State<PhotoSelector> {
  Diary _diary;
  File _image;
  final picker = ImagePicker();

  _PhotoSelectorState(this._diary) {
    if (_diary.image != null) {
      _image = File(_diary.image);
    }
  }

  void _selectPhoto() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    setState(() {
      var path = pickedFile.path;
      _diary = Diary(image: path, text: _diary.text);
      _image = File(path);
    });
  }

  // 日記編集画面へ
  void _editDiary(BuildContext context) async {
    Diary res = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return DiaryEditor(widget.title, _diary);
      }),
    );
    if (res != null) {
      Navigator.of(context).pop(res);
    }
  }

  Widget _editDiaryButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _editDiary(context),
      tooltip: "日記を書く",
      child: Icon(Icons.article_outlined),
    );
  }
  Widget _selectPhotoButton() {
    return ElevatedButton.icon(
      onPressed: _selectPhoto,
      icon: Icon(Icons.insert_photo_rounded),
      label: Text("写真設定"));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () {
        // 戻る->変更無し
        Navigator.of(context).pop(widget.diary);
      },
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment(0, -1),
                child: Container(
                  height: height/3,
                  child: PhotoImage(_image),
                ),
              ),
              Align(
                alignment: Alignment(1, 1),
                child: Container(
                  child: _selectPhotoButton(),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: _editDiaryButton(context),
      ),
    );
  }
}
