import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final notesRepositoryProvider = Provider((ref) => NotesRepository());

class NotesRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addNote(String userId, String content) async {
    await _firestore.collection('notes').add({
      'userId': userId,
      'content': content,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<Map<String, dynamic>>> getNotes(String userId) {
    return _firestore
        .collection('notes')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => doc.data()).toList());
  }
}
