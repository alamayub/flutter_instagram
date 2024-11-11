import 'package:flutter/material.dart';

extension DismissKeyboardExtension on Widget {
  void dismissKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
}