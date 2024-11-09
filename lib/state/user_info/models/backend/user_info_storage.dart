import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable, debugPrint;
import 'package:instagram/state/auth/constants/firebase_collection_name.dart';
import 'package:instagram/state/auth/constants/firebase_field_name.dart';
import 'package:instagram/state/posts/typedefs/user_id.dart';
import 'package:instagram/state/user_info/models/user_info_payload.dart';

@immutable
class UserInfoStorage {
  const UserInfoStorage();

  Future<bool> saveUserInfo({
    required UserId userId,
    required String? name,
    required String? email,
  }) async {
    try {
      final userInfo = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.users)
          .where(FirebaseFieldName.userId, isEqualTo: userId)
          .limit(1)
          .get();
      if (userInfo.docs.isNotEmpty) {
        await userInfo.docs.first.reference.update({
          FirebaseFieldName.displayName: name ?? '',
          FirebaseFieldName.email: email ?? '',
        });
        return true;
      }
      final payload = UserInfoPayload(
        userId: userId,
        displayName: name,
        email: email,
      );
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.users)
          .add(payload);
      return true;
    } catch (e) {
      debugPrint('ERROR WHILE SAVING ${e.toString()}');
      return false;
    }
  }
}
