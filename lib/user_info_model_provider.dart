import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram/state/auth/constants/firebase_collection_name.dart';
import 'package:instagram/state/auth/constants/firebase_field_name.dart';
import 'package:instagram/state/posts/typedefs/user_id.dart';
import 'package:instagram/user_info_model.dart';

final userInfoModelProvider = StreamProvider.family
    .autoDispose<UserInfoModel, UserId>((ref, UserId userId) {
  final controller = StreamController<UserInfoModel>();
  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.users)
      .where(FirebaseFieldName.userId, isEqualTo: userId)
      .limit(1)
      .snapshots()
      .listen((snap) {
    final doc = snap.docs.first;
    final json = doc.data();
    final userInfoModel = UserInfoModel.fromMap(json, userId: userId);
    controller.add(userInfoModel);
  });
  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});
