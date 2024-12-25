import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_scalable_app/features/notes/domain/notes_notifier.dart';

class NotesScreen extends ConsumerWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesState = ref.watch(notesNotifierProvider);
    final notesNotifier = ref.read(notesNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      body: notesState.isLoading
          ? const CircularProgressIndicator()
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: notesState.notes.length,
              itemBuilder: (context, index) {
                final note = notesState.notes[index];
                return ListTile(
                  title: Text(note['content']),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => notesNotifier.addNote("New Note Content"),
              child: const Text("Add Note"),
            ),
          )
        ],
      ),
    );
  }
}
