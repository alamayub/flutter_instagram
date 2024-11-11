import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram/state/auth/constants/firebase_collection_name.dart';

class DeleteCommentNotifier extends StateNotifier<bool> {
  DeleteCommentNotifier() : super(false);
  
  set isLoading(bool val) => state = val;

  Future<bool> deleteComment({required String commentId}) async {
    try {
      isLoading = true;
      final query = FirebaseFirestore.instance
          .collection(FirebaseCollectionName.comments)
          .where(FieldPath.documentId, isEqualTo: commentId)
          .limit(1)
          .get();
      await query.then((query) async {
        for (final doc in query.docs) {
          await doc.reference.delete();
        }
      });
      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}

final deleteCommentNotifierProvider =
    StateNotifierProvider<DeleteCommentNotifier, bool>(
  (_) => DeleteCommentNotifier(),
);
