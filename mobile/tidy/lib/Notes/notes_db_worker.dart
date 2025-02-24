// import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../utils.dart' as utils; //* Подключаем утилиты для docsDir
import 'notes_provider.dart';

class NotesDbWorker {
  NotesDbWorker._();
  static final NotesDbWorker db = NotesDbWorker._();

  late Database _db;

  //* Получение экземпляра базы данных
  Future<Database> get database async {
    return _db;
  }

  //* Инициализация БД SQLite
  Future<Database> init() async {
    String path = join(utils.docsDir!.path, 'notes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS notes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            content TEXT,
            color TEXT
          )
        ''');
      },
    );
  }

  //* Преобразование Map в объект Note
  Note noteFrommap(Map inMap) {
    Note note = Note();
    note.id = inMap['id'];
    note.title = inMap['title'];
    note.content = inMap['content'];
    note.color = inMap['color'];
    return note;
  }

  //* Преобразование объекта Note в Map
  Map<String, dynamic> noteToMap(Note inNote) {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = inNote.id;
    map['title'] = inNote.title;
    map['content'] = inNote.content;
    map['color'] = inNote.color;
    return map;
  }

  //* Добавление новой заметки
  Future<int> create(Note note) async {
    Database db = await database;
    return await db.insert('notes', noteToMap(note));
  }

  //* Получение заметки по ID
  Future<Note?> get(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> results =
        await db.query('notes', where: 'id = ?', whereArgs: [id]);
    return results.isNotEmpty ? noteFrommap(results.first) : null;
  }

  //* Получение всех заметок
  Future<List<Note>> getAll() async {
    Database db = await database;
    List<Map<String, dynamic>> results = await db.query('notes');
    return results.map((map) => noteFrommap(map)).toList();
  }

  //* Обновление заметки
  Future<int> update(Note note) async {
    Database db = await database;
    return await db.update(
      'notes',
      noteToMap(note),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  //* Удаление заметки
  Future<int> delete(int id) async {
    Database db = await database;
    return await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
