import 'dart:io';

import 'package:flutter/foundation.dart' show immutable;

enum FileType { image, video }

@immutable
class ThumbnailRequest {
  final File file;
  final FileType fileType;
  const ThumbnailRequest({
    required this.file,
    required this.fileType,
  });

  ThumbnailRequest copyWith({
    File? file,
    FileType? fileType,
  }) =>
      ThumbnailRequest(
        file: file ?? this.file,
        fileType: fileType ?? this.fileType,
      );

  @override
  String toString() => 'ThumbnailRequest(file: $file, fileType: $fileType)';

  @override
  bool operator ==(covariant ThumbnailRequest other) {
    if (identical(this, other)) return true;

    return other.file == file && other.fileType == fileType;
  }

  @override
  int get hashCode => file.hashCode ^ fileType.hashCode;
}

extension CollectionName on FileType {
  String get collectionName {
    switch (this) {
      case FileType.video:
        return 'videos';
      case FileType.image:
        return 'images';
    }
  }
}
