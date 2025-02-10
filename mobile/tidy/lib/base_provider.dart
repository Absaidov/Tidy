import 'package:flutter/material.dart';
// import 'package:scoped_model/scoped_model.dart';

class BaseProvider extends ChangeNotifier {
  int _stackIndex = 0;
  List _entityList = [];
  //* Исправить тип переменной (предварительно на String)
  var _entityBeingEdited;
  String? _chosenDate;

  //* Геттеры
  int get stackIndex => _stackIndex;
  List get entityList => _entityList;
  dynamic get entityBeingEdited => _entityBeingEdited;
  String? get chosenDate => _chosenDate;

  //* Сеттер
  //* Установка выбранной даты
  void setChosenDate(String inDate) {
    _chosenDate = inDate;
    notifyListeners(); //* Обновить UI
  }

  //* Загрузка данных
  Future<void> loadData(String inEntityType, dynamic inDatabase) async {
    _entityList = await inDatabase.getAll();
  }

  //* Переключение между экранами
  void setStackIndex(int inStackIndex) {
    _stackIndex = inStackIndex;
    notifyListeners(); //* Обновить UI
  }
}
