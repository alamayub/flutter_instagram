import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram/state/auth/providers/auth_state_provider.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram Clone'),
      ),
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            return TextButton(
              onPressed: () => ref.read(authStateProvider.notifier).logout(),
              child: const Text('LOGOUT'),
            );
          },
        ),
      ),
    );
  }
}
