import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram/image_upload/image_upload_notifier.dart';
import 'package:instagram/state/auth/providers/auth_state_provider.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  final isImageUploading = ref.watch(imageUploadNotifierProvider);
  return authState.isLoading || isImageUploading;
});
