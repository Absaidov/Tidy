import 'package:tidy/base_model.dart';

import '../Notes/notes_model.dart';

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

class NotesModel extends BaseProvider {
  late String color;

  void setColor(String inColor) {
    color = inColor;
    notifyListeners();
  }
}

NotesModel notesModel = NotesModel();
