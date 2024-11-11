import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram/date_sorting_enum.dart';
import 'package:instagram/posts/comment.dart';
import 'package:instagram/posts/request_for_posts_and_comments.dart';
import 'package:instagram/state/auth/constants/firebase_collection_name.dart';
import 'package:instagram/state/auth/constants/firebase_field_name.dart';

final postCommentsProvider = StreamProvider.family
    .autoDispose<Iterable<Comment>, RequestForPostsAndComments>(
        (ref, RequestForPostsAndComments request) {
  final controller = StreamController<Iterable<Comment>>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.comments)
      .where(FirebaseFieldName.postId, isEqualTo: request.postId)
      .snapshots()
      .listen((snap) {
    final docs = snap.docs;
    final limitedDocs =
        request.limit != null ? docs.take(request.limit!) : docs;
    final comments = limitedDocs
        .where((doc) => !doc.metadata.hasPendingWrites)
        .map((com) => Comment.fromMap(com.data(), id: com.id));
    final result = comments.applySortingFrom(request);
    controller.sink.add(result);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});
