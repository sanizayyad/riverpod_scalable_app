import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_scalable_app/features/auth/domain/auth_notifier.dart';
import 'package:riverpod_scalable_app/features/notes/data/notes_repository.dart';


final notesNotifierProvider = NotifierProvider<NotesNotifier, NotesState>(NotesNotifier.new);

class NotesState {
  final List<Map<String, dynamic>> notes;
  final bool isLoading;
  final String? error;

  NotesState({this.notes = const [], this.isLoading = false, this.error});

  NotesState copyWith({
    List<Map<String, dynamic>>? notes,
    bool? isLoading,
    String? error,
  }) {
    return NotesState(
      notes: notes ?? this.notes,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class NotesNotifier extends Notifier<NotesState> {
  late final NotesRepository _repository;

  @override
  NotesState build() {
    _repository = ref.read(notesRepositoryProvider);
    _fetchNotes();
    return NotesState();
  }

  Future<void> _fetchNotes() async {
    state = state.copyWith(isLoading: true);
    try {
      final userId = ref.read(authNotifierProvider).userId!;
      final notesStream = _repository.getNotes(userId);
      notesStream.listen((notes) {
        state = state.copyWith(notes: notes, isLoading: false);
      });
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> addNote(String content) async {
    final userId = ref.read(authNotifierProvider).userId!;
    await _repository.addNote(userId, content);
  }
}