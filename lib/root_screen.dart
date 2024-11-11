import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram/dialogs/alert_dialog_model.dart';
import 'package:instagram/image_upload/create_new_post_view.dart';
import 'package:instagram/image_upload/image_picker_helper.dart';
import 'package:instagram/image_upload/thumbnail_request.dart';
import 'package:instagram/dialogs/logout_dialog.dart';
import 'package:instagram/state/auth/providers/auth_state_provider.dart';

class RootScreen extends ConsumerWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram Clone'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer(
            builder: (context, ref, child) {
              return TextButton(
                onPressed: () async {
                  var result = await const LogoutDialog()
                      .present(context)
                      .then((val) => val ?? false);
                  if (result) {
                    ref.read(authStateProvider.notifier).logout();
                  }
                },
                child: const Text('LOGOUT'),
              );
            },
          ),
          TextButton(
            onPressed: () async {
              var file = await ImagePickerHelper.pickImagefromGallery();
              if (file == null) {
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CreateNewPostView(
                    file: file,
                    fileType: FileType.image,
                  ),
                ),
              );
            },
            child: const Text('PICK IMAGE'),
          ),
          TextButton(
            onPressed: () async {
              var file = await ImagePickerHelper.pickVideofromGallery();
              if (file == null) {
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CreateNewPostView(
                    file: file,
                    fileType: FileType.video,
                  ),
                ),
              );
            },
            child: const Text('PICK VIDEO'),
          )
        ],
      ),
    );
  }
}
