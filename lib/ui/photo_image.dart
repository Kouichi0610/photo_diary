import 'dart:io';
import 'package:flutter/material.dart';

class PhotoImage extends StatelessWidget {
  final File _image;
  const PhotoImage(this._image);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _image == null ? Text("No Image.") : Image.file(_image),
    );
  }
}
