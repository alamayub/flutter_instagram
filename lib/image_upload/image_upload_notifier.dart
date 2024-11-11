import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram/image_upload/get_image_aspect_ratio_extension.dart';
import 'package:instagram/image_upload/thumbnail_exception.dart';
import 'package:instagram/image_upload/thumbnail_request.dart';
import 'package:instagram/state/auth/constants/firebase_collection_name.dart';
import 'package:instagram/state/posts/typedefs/user_id.dart';
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ImageUploadNotifier extends StateNotifier<bool> {
  ImageUploadNotifier() : super(false);

  set isLoading(bool val) => state = val;

  Future<bool> upload({
    required File file,
    required FileType fileType,
    required String message,
    required Map<String, dynamic> postSetting,
    required UserId userId,
  }) async {
    isLoading = true;
    late Uint8List thumbnailUint8list;
    switch (fileType) {
      case FileType.image:
        final fileAsImg = img.decodeImage(file.readAsBytesSync());
        if (fileAsImg == null) {
          isLoading = false;
          throw CouldNotBuildThumbnailException();
        }
        final thumbnail = img.copyResize(fileAsImg, width: 150);
        final thumbnailData = img.encodeJpg(thumbnail);
        thumbnailUint8list = Uint8List.fromList(thumbnailData);
        break;
      case FileType.video:
        final thumb = await VideoThumbnail.thumbnailData(
          video: file.path,
          imageFormat: ImageFormat.JPEG,
          maxHeight: 150,
          quality: 80,
        );
        if (thumb == null) {
          isLoading = false;
          throw CouldNotBuildThumbnailException();
        } else {
          thumbnailUint8list = thumb;
        }
        break;
    }
    final thumbnailAspectRatio = await thumbnailUint8list.getAspectRatio();
    final fileName = const Uuid().v4();
    final thumbnailRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(FirebaseCollectionName.thumbnails)
        .child(fileName);
    final originalFileRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(fileType.collectionName)
        .child(fileName);
    try {
      final thumbnailUploadTask =
          await thumbnailRef.putData(thumbnailUint8list);
      final thumbnailStorageId = thumbnailUploadTask.ref.name;

      final originalFileUploadTask = await originalFileRef.putFile(file);
      final originalFileStorageId = originalFileUploadTask.ref.name;

      final thumbnailURL = await thumbnailRef.getDownloadURL();
      final originalFileURL = await originalFileRef.getDownloadURL();
      return true;
    } catch (e) {
      debugPrint('ERROR WHILE UPLOADING IMAGE ${e.toString()}');
      return false;
    } finally {
      isLoading = false;
    }
  }
}

final imageUploadNotifierProvider =
    StateNotifierProvider<ImageUploadNotifier, bool>(
  (ref) => ImageUploadNotifier(),
);
