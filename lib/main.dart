import 'package:flutter/material.dart';
import 'note.dart';
import 'note_service.dart';
import 'add_note_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NoteListScreen(),
    );
  }
}

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  final NoteService _noteService = NoteService();
  List<Note> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final notes = await _noteService.getNotes();
    setState(() {
      _notes = notes;
    });
  }

  Future<void> _addNote() async {
    final newNote = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNoteScreen()),
    );
    if (newNote != null) {
      setState(() {
        _notes.add(newNote);
      });
      _noteService.saveNotes(_notes);
    }
  }

  Future<void> _deleteNote(int index) async {
    setState(() {
      _notes.removeAt(index);
    });
    _noteService.saveNotes(_notes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addNote,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          final note = _notes[index];
          return ListTile(
            title: Text(note.title),
            subtitle: Text(note.description),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteNote(index),
            ),
          );
        },
      ),
    );
  }
}
