import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:scoped_model/scoped_model.dart';
import 'package:tidy/Constants/constants.dart';
import 'package:tidy/main.dart';
import 'notes_db_worker.dart';
import 'notes_entry.dart';
import 'notes_list.dart';
import 'notes_provider.dart' show NotesProvider;

class Notes extends StatelessWidget {
  const Notes({super.key});

  Future<void> _loadNotes(BuildContext context) async {
    await context.read<NotesProvider>().loadData("notes", "NotesDBWorker.db");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadNotes(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          backgroundColor: white,
          body: SafeArea(
            bottom: false,
            child: IndexedStack(
              index: context.watch<NotesProvider>().stackIndex,
              children: const [
                // NotesList(),
                // NotesEntry(),
              ],
            ),
          ),
        );
      },
    );
  }
}
