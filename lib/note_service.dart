import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
import 'note.dart';

class NoteService {
  static const _key = 'notes';

  Future<List<Note>> getNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesString = prefs.getString(_key) ?? '[]';
    final List<dynamic> notesJson = jsonDecode(notesString);
    return notesJson.map((json) => Note.fromMap(json)).toList();
  }

  Future<void> saveNotes(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = jsonEncode(notes.map((note) => note.toMap()).toList());
    await prefs.setString(_key, notesJson);
  }
}
