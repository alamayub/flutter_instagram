import 'package:flutter/foundation.dart' show immutable;

import 'package:instagram/date_sorting_enum.dart';

@immutable
class RequestForPostsAndComments {
  final String postId;
  final bool sortByCreatedAt;
  final DateSortingEnum dateSorting;
  final int? limit;
  const RequestForPostsAndComments({
    required this.postId,
    required this.sortByCreatedAt,
    required this.dateSorting,
    this.limit,
  });

  RequestForPostsAndComments copyWith({
    String? postId,
    bool? sortByCreatedAt,
    DateSortingEnum? dateSorting,
    int? limit,
  }) =>
      RequestForPostsAndComments(
        postId: postId ?? this.postId,
        sortByCreatedAt: sortByCreatedAt ?? this.sortByCreatedAt,
        dateSorting: dateSorting ?? this.dateSorting,
        limit: limit ?? this.limit,
      );

  @override
  String toString() =>
      'RequestForPostsAndComments(postId: $postId, sortByCreatedAt: $sortByCreatedAt, dateSorting: $dateSorting, limit: $limit)';

  @override
  bool operator ==(covariant RequestForPostsAndComments other) {
    if (identical(this, other)) return true;

    return other.postId == postId &&
        other.sortByCreatedAt == sortByCreatedAt &&
        other.dateSorting == dateSorting &&
        other.limit == limit;
  }

  @override
  int get hashCode =>
      postId.hashCode ^
      sortByCreatedAt.hashCode ^
      dateSorting.hashCode ^
      limit.hashCode;
}
