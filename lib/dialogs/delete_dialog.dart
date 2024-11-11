import 'package:flutter/material.dart';
import 'package:instagram/dialogs/alert_dialog_model.dart';
import 'package:instagram/views/components/constants/srings.dart';

@immutable
class DeleteDialog extends AlertDialogModel<bool> {
  const DeleteDialog({required String titleOfObjectToDelete})
      : super(
          title: '${Strings.delete} $titleOfObjectToDelete',
          message: '${Strings.deleteDescription} $titleOfObjectToDelete?',
          buttons: const {
            Strings.cancle: false,
            Strings.delete: true,
          },
        );
}
