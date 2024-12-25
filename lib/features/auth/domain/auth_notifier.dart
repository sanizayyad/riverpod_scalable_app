import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_scalable_app/features/auth/data/firebase_auth_repository.dart';
import 'package:riverpod_scalable_app/providers/isAuthenticated_provider.dart';

class AuthState {
  final bool isLoading;
  final String? userId;
  final String? error;

  AuthState({this.isLoading = false, this.userId, this.error});

  AuthState copyWith({bool? isLoading, String? userId, String? error}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      userId: userId ?? this.userId,
      error: error,
    );
  }
}

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

class AuthNotifier extends Notifier<AuthState> {
  late final FirebaseAuthRepository _repository;

  @override
  AuthState build() {
    _repository = ref.read(authRepositoryProvider);
    return AuthState();
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true);
    try {
      final user = await _repository.login(email, password);
      state = state.copyWith(isLoading: false, userId: user?.uid);
      ref.read(isAuthenticatedProvider.notifier).state = true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    state = AuthState();
    ref.read(isAuthenticatedProvider.notifier).state = false;
  }
}
