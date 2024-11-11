// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram/state/auth/constants/firebase_field_name.dart';

import 'package:instagram/state/posts/typedefs/user_id.dart';

@immutable
class UserInfoModel {
  final UserId userId;
  final String displayName;
  final String? email;
  const UserInfoModel({
    required this.userId,
    required this.displayName,
    this.email,
  });

  UserInfoModel copyWith({
    UserId? userId,
    String? displayName,
    String? email,
  }) =>
      UserInfoModel(
        userId: userId ?? this.userId,
        displayName: displayName ?? this.displayName,
        email: email ?? this.email,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        FirebaseFieldName.userId: userId,
        FirebaseFieldName.displayName: displayName,
        FirebaseFieldName.email: email,
      };

  factory UserInfoModel.fromMap(
    Map<String, dynamic> map, {
    required String userId,
  }) =>
      UserInfoModel(
        userId: map[FirebaseFieldName.userId] as UserId,
        displayName: map[FirebaseFieldName.displayName] as String,
        email: map[FirebaseFieldName.email] != null
            ? map[FirebaseFieldName.email] as String
            : null,
      );

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'UserInfoModel(userId: $userId, displayName: $displayName, email: $email)';

  @override
  bool operator ==(covariant UserInfoModel other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.displayName == displayName &&
        other.email == email;
  }

  @override
  int get hashCode => userId.hashCode ^ displayName.hashCode ^ email.hashCode;
}
