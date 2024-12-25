import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_scalable_app/features/auth/domain/auth_notifier.dart';

final isAuthenticatedProvider = StateProvider<bool>(
    (ref) => ref.watch(authNotifierProvider).userId != null);
