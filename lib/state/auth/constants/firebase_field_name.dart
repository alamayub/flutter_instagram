import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseFieldName {
  static const userId = 'uid';
  static const postId = 'post_id';
  static const comment = 'comment';
  static const displayName = 'display_name';
  static const email = 'email';
  static const createdAt = 'created_at';
  static const date = 'date';
  const FirebaseFieldName._();
}
