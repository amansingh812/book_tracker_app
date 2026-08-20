import 'package:readora/features/auth/domain/entities/app_user.dart';

/// The domain's view of authentication. The presentation layer never imports
/// `supabase_flutter`; it talks to this.
abstract interface class AuthRepository {
  /// Emits on every identity change, including the initial value.
  Stream<AppUser?> get changes;

  /// Current identity, or null when the user has not chosen guest or account yet.
  AppUser? get current;

  Future<AppUser> signUp({
    required String email,
    required String password,
    String? displayName,
  });

  Future<AppUser> signIn({required String email, required String password});

  Future<void> sendPasswordReset(String email);

  /// Enters local-only mode. No network calls are made until the user signs up.
  Future<AppUser> continueAsGuest();

  /// Moves everything created in guest mode onto the freshly created account.
  /// Called exactly once, immediately after a guest signs up.
  Future<void> migrateGuestData(String newUserId);

  Future<void> signOut();
}
