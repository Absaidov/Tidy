// import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../utils.dart' as utils; //* Подключаем утилиты для docsDir
import 'notes_provider.dart';

class NotesDbWorker {
  NotesDbWorker._();
  static final NotesDbWorker db = NotesDbWorker._();

  Database? _db;

  //* Получение экземпляра базы данных
  Future<Database?> get database async {
    _db ??= await init();
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

  // Future create(Note inNote) async {
  //   Database db = await database;
  //   var val = await db.rawQuery(
  //     'SELECT MAX(id) + 1 AS id FROM notes',
  //   );
  //   dynamic id = val.first["id"];

  //   id ??= 1;
  //   return await db.rawInsert(
  //       'INSERT INTO notes (id, title, content, color)'
  //       'VALUES(?, ?, ?, ?)',
  //       [id, inNote.title, inNote.content, inNote.color]);
  // }
  /// Добавление новой заметки
  Future<int> create(Note note) async {
    Database db = await database;
    return await db.insert('notes', noteToMap(note));
  }

  Future<Note> get(int inID) async {
    Database db = await database;
    var rec = await db.query(
      'notes',
      where: 'id = ?',
      whereArgs: [inID],
    );
    return noteFrommap(rec.first);
  }

  Future<List> getAll() async {
    Database db = await database;
    var recs = await db.query('notes');
    var list = recs.isNotEmpty ? recs.map((m) => noteFrommap(m)).toList() : [];
    return list;
  }

  Future update(Note note) async {
    Database db = await database;
    return await db.update('notes', noteToMap(note),
        where: 'id = ?', whereArgs: [note.id]);
  }

  Future delete(int inID) async {
    Database db = await database;
    return await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [inID],
    );
  }
}
