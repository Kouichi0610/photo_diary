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

  bool equals(Diary other) {
    return image == other.image && text == other.text;
  }

  @override
  String toString() {
    if (empty()) return "(empty)";
    return "Text:${text} Image:${image}";
  }
}
