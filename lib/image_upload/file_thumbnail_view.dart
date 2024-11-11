import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram/image_upload/thumbnail_provider.dart';
import 'package:instagram/image_upload/thumbnail_request.dart';

class FileThumbnailView extends ConsumerWidget {
  final ThumbnailRequest thumbnailRequest;
  const FileThumbnailView({
    super.key,
    required this.thumbnailRequest,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thumbanail = ref.watch(thumbnailProvider(thumbnailRequest));
    return thumbanail.when(
      data: (data) => AspectRatio(
        aspectRatio: data.aspectRatio,
        child: data.image,
      ),
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => CircularProgressIndicator(),
    );
  }
}
