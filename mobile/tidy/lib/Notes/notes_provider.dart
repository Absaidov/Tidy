import 'package:tidy/base_provider.dart';

import 'notes_provider.dart';

class Note {
  late int id;
  late String title;
  late String content;
  late String color;

  @override
  String toString() {
    return "{ id=$id, title=$title, "
        "content=$content, color=$color}";
  }
}

class NotesProvider extends BaseProvider {
  late String color;

  void setColor(String inColor) {
    color = inColor;
    notifyListeners();
  }
}
