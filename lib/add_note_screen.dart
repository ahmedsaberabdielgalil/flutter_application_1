import 'package:flutter/material.dart';
import 'note.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _saveNote() {
    final title = _titleController.text;
    final description = _descriptionController.text;
    if (title.isNotEmpty && description.isNotEmpty) {
      final note = Note(
        title: title,
        description: description,
      );
      Navigator.pop(context, note);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 4,
            ),
          ],
        ),
      ),
    );
  }
}
