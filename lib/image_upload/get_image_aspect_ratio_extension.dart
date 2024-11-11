import 'package:flutter/material.dart' as material
    show Image, ImageConfiguration, ImageStreamListener;
import 'dart:async' show Completer;

import 'package:flutter/foundation.dart' show Uint8List;

extension GetImageAspectRatioExtension on material.Image {
  Future<double> getAspectRatio() async {
    final competer = Completer<double>();
    image.resolve(const material.ImageConfiguration()).addListener(
      material.ImageStreamListener(
        (imgInfo, synchronousCall) {
          final aspectRatio = imgInfo.image.width / imgInfo.image.height;
          imgInfo.dispose();
          competer.complete(aspectRatio);
        },
      ),
    );
    return competer.future;
  }
}

extension GetImageDataAspectRatioExtension on Uint8List {
  Future<double> getAspectRatio() async {
    final image = material.Image.memory(this);
    return image.getAspectRatio();
  }
}
