// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;

@immutable
class Comment {
  final String id;
  final String comment;
  final DateTime createdAt;
  final String fromUserId;
  final String postId;
  const Comment({
    required this.id,
    required this.comment,
    required this.createdAt,
    required this.fromUserId,
    required this.postId,
  });

  Comment copyWith({
    String? id,
    String? comment,
    DateTime? createdAt,
    String? fromUserId,
    String? postId,
  }) =>
      Comment(
        id: id ?? this.id,
        comment: comment ?? this.comment,
        createdAt: createdAt ?? this.createdAt,
        fromUserId: fromUserId ?? this.fromUserId,
        postId: postId ?? this.postId,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'comment': comment,
        'createdAt': createdAt.millisecondsSinceEpoch,
        'fromUserId': fromUserId,
        'postId': postId,
      };

  factory Comment.fromMap(
    Map<String, dynamic> map, {
    required String id,
  }) {
    return Comment(
      id: map['id'] as String,
      comment: map['comment'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      fromUserId: map['fromUserId'] as String,
      postId: map['postId'] as String,
    );
  }

  String toJson() => json.encode(toMap());


  @override
  String toString() =>
      'Comment(id: $id, comment: $comment, createdAt: $createdAt, fromUserId: $fromUserId, postId: $postId)';

  @override
  bool operator ==(covariant Comment other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.comment == comment &&
        other.createdAt == createdAt &&
        other.fromUserId == fromUserId &&
        other.postId == postId;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      comment.hashCode ^
      createdAt.hashCode ^
      fromUserId.hashCode ^
      postId.hashCode;
}
