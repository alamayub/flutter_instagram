import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram/image_upload/file_thumbnail_view.dart';
import 'package:instagram/image_upload/image_upload_notifier.dart';
import 'package:instagram/image_upload/thumbnail_request.dart';
import 'package:instagram/state/auth/providers/user_id_provider.dart';

class CreateNewPostView extends ConsumerStatefulWidget {
  final File file;
  final FileType fileType;
  const CreateNewPostView({
    required this.file,
    required this.fileType,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateNewPostViewState();
}

class _CreateNewPostViewState extends ConsumerState<CreateNewPostView> {
  @override
  Widget build(BuildContext context) {
    final thumbnailRequest = ThumbnailRequest(
      file: widget.file,
      fileType: widget.fileType,
    );
    final postController = useTextEditingController();
    final isPostButtonEnabled = useState(false);
    useEffect(() {
      void listener() {
        isPostButtonEnabled.value = postController.text.isNotEmpty;
      }

      postController.addListener(listener);
      return () {
        postController.removeListener(listener);
      };
    }, [postController]);
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Post'),
        actions: [
          IconButton(
            onPressed: isPostButtonEnabled.value
                ? () async {
                    final userId = ref.read(userIdProvider);
                    if (userId == null) {
                      return;
                    }
                    final message = postController.text.trim();
                    final isUploaded = await ref
                        .refresh(imageUploadNotifierProvider.notifier)
                        .upload(
                          file: widget.file,
                          fileType: widget.fileType,
                          message: message,
                          postSetting: {},
                          userId: userId,
                        );
                    if (isUploaded && mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                : null,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FileThumbnailView(
            thumbnailRequest: thumbnailRequest,
          ),
          TextField(
            maxLines: null,
            autofocus: true,
            controller: postController,
            decoration: InputDecoration(
              hintText: 'Write comething...',
            ),
          ),
        ],
      ),
    );
  }
}
