import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_diary/domain/diary.dart';
import 'package:photo_diary/ui/photo_image.dart';

/*
  TODO:return Diary
 */
class PhotoDiary extends StatefulWidget {
  const PhotoDiary({Key key, this.title, this.diary, this.editMode}) :super(key: key);

  final String title;
  final bool editMode;
  final Diary diary;

  @override
  State<StatefulWidget> createState() => _PhotoDiaryState(diary);
}

class _PhotoDiaryState extends State<PhotoDiary> {
  _PhotoDiaryState(Diary diary) {
    _diary = diary;
    if (diary.image != null) {
      _image = File(diary.image);
    }
  }

  Diary _diary = Diary.none();
  File _image = null;
  final picker = ImagePicker();

  void _camera() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    print("PickedFile:${pickedFile.path}");
    print("File:${pickedFile.toString()}");

    if (pickedFile == null) {
      print("no file.");
      return;
    }

    setState(() {
      var path = pickedFile.path;
      _diary = Diary(image: path, text: _diary.text);
      _image = File(path);
      print("Path:${path}");
    });
  }

  Widget _noImage() {
    return Center(
      child: Text('No Image.'),
    );
  }

  void _textChanged(String text) {
    print("Changed:${text}");
  }

  TextEditingController _inputController = TextEditingController();

  // TODO:大体半分くらい
  // TODO:Stackで重ねる
  // TODO:Edit(横並び) View(縦並び)に分ける
  // TODO:TextFieldでは下にテキスト置いたとき、編集時に見えない
  // TODO:photoselect -> textedit -> return
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double deviceWidth = size.width;
    final double deviceHeight = size.height;

    print("size:${size.toString()}");


    // WillPopScope 戻る(左上)押下時に戻り値を渡す
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop(Diary.none());
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                child: PhotoImage(_image),
                width: double.maxFinite,
                height: deviceHeight/3,
                decoration: _decoration(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                  child: Container(
                  // autofocus: キーボードを開いている
                  child: TextField(
                    controller: _inputController,
                    enabled: true,
                    maxLines: 10,
                    style: TextStyle(color: Colors.black),
                    onChanged: _textChanged,
                    keyboardType: TextInputType.multiline,
                    onTap: () {
                      print("onTap");
                    },
                  ),
                  width: double.maxFinite,
                  height: deviceHeight/3,
                  decoration: _decoration(),
                ),
              ),
              ElevatedButton(onPressed: () async {
                Navigator.pop(context, Diary(image: "imageA", text: "あああああああ"));
              },
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _camera,
          tooltip: "写真撮影",
          child: Icon(Icons.add_a_photo),
        ),
      ),
    );
  }

  Decoration _decoration() {
    const BorderSide side = BorderSide(color: Colors.red, width: 1);
    return BoxDecoration(
      border: const Border(
        left: side,
        top: side,
        right: side,
        bottom: side,
      ),
    );
  }

}
