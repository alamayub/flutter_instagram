import 'package:flutter/foundation.dart' show immutable;

@immutable
class Strings {
  static const allowLikesTitle = 'Allow Likes';
  static const allowLikesDescription =
      'By allowing likes, users will be able to press the like button on your post.';
  static const allowLikesStorageKey = 'allow_likes';
  static const allowCommentsTitle = 'Allow Comments';
  static const allowCommentsDescription =
      'By allowing likes, users will be able to comment on your post.';
  static const allowCommentsStorageKey = 'allow_comments';
  static const comment = 'comment';
  static const loading = 'Loading...';
  static const person = 'person';
  static const people = 'people';
  static const likedThis = 'liked this';
  static const delete = 'Delete';
  static const deleteDescription = 'Are you sure that you want to delete this?';
  static const logout = 'Logout';
  static const logoutDescription =
      'Are you sure that you want to logout of the app?';
  static const cancle = 'Cancel';

  const Strings._();
}
