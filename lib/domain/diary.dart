/*
  日記
 */
class Diary {
  final String image;
  final String text;

  const Diary({this.image, this.text});
  Diary.none() : this(image: null, text: null);

  bool empty() {
    return image == null || text == null;
  }

  @override
  String toString() {
    return "Text:${text} Image:${image}";
  }
}
