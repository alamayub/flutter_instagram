import 'package:flutter/material.dart';
import 'package:instagram/dialogs/alert_dialog_model.dart';
import 'package:instagram/views/components/constants/srings.dart';

@immutable
class LogoutDialog extends AlertDialogModel<bool> {
  const LogoutDialog()
      : super(
          title: Strings.logout,
          message: Strings.logoutDescription,
          buttons: const {
            Strings.cancle: false,
            Strings.logout: true,
          },
        );
}
