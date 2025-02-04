import 'package:scoped_model/scoped_model.dart';

class BaseModel extends Model {
  int stackIndex = 0;
  List entitylist = [];
  var entityBeingEdited;
  String? chosenDate;
  void setChosenDate(String inDate) {
    chosenDate = inDate;
    notifyListeners();
  }

  void setStackIndex(int inStackIndex) {
    stackIndex = inStackIndex;
    notifyListeners();
  }
}
