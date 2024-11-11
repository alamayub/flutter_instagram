import 'package:instagram/posts/comment.dart';
import 'package:instagram/posts/request_for_posts_and_comments.dart';

enum DateSortingEnum { newestOnTop, oldestOnTop }

// dynamic is parent model
extension Sorting on Iterable<Comment> {
  Iterable<Comment> applySortingFrom(RequestForPostsAndComments request) {
    if (request.sortByCreatedAt) {
      final res = toList()
        ..sort(
          (a, b) {
            switch (request.dateSorting) {
              case DateSortingEnum.newestOnTop:
                return b.createdAt.compareTo(a.createdAt);
              case DateSortingEnum.oldestOnTop:
                return a.createdAt.compareTo(b.createdAt);
            }
          },
        );
      return res;
    } else {
      return this;
    }
  }
}
