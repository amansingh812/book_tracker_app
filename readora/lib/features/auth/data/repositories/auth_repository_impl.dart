import 'dart:async';

import 'package:readora/core/error/error_mapper.dart';
import 'package:readora/core/error/failure.dart';
import 'package:readora/core/sync/sync_engine.dart';
import 'package:readora/features/auth/domain/entities/app_user.dart';
import 'package:readora/features/auth/domain/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required SupabaseClient supabase,
    required SharedPreferences prefs,
    required SyncEngine syncEngine,
  })  : _supabase = supabase,
        _prefs = prefs,
        _syncEngine = syncEngine {
    _controller.add(current);
    _authSub = _supabase.auth.onAuthStateChange.listen((_) {
      _controller.add(current);
    });
  }

  static const _guestKey = 'readora.guest_mode';

  final SupabaseClient _supabase;
  final SharedPreferences _prefs;
  final SyncEngine _syncEngine;

  final _controller = StreamController<AppUser?>.broadcast();
  StreamSubscription<AuthState>? _authSub;

  @override
  Stream<AppUser?> get changes => _controller.stream;

  @override
  AppUser? get current {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      return AppUser(
        id: user.id,
        email: user.email,
        displayName: user.userMetadata?['display_name'] as String?,
      );
    }
    return _prefs.getBool(_guestKey) ?? false ? AppUser.guest : null;
  }

  @override
  Future<AppUser> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    return guard(() async {
      final wasGuest = _prefs.getBool(_guestKey) ?? false;

      final res = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {if (displayName != null) 'display_name': displayName},
      );
      final user = res.user;
      if (user == null) {
        throw const AuthFailure('Check your inbox to confirm your email, then sign in.');
      }

      if (wasGuest) await migrateGuestData(user.id);
      await _prefs.setBool(_guestKey, false);

      return AppUser(id: user.id, email: user.email, displayName: displayName);
    });
  }

  @override
  Future<AppUser> signIn({required String email, required String password}) {
    return guard(() async {
      final res = await _supabase.auth.signInWithPassword(email: email, password: password);
      final user = res.user!;
      await _prefs.setBool(_guestKey, false);
      // A fresh device must pull the whole library, not just what changed since
      // some cursor left over from a previous account.
      await _syncEngine.resetCursors();
      unawaited(_syncEngine.syncNow());
      return AppUser(
        id: user.id,
        email: user.email,
        displayName: user.userMetadata?['display_name'] as String?,
      );
    });
  }

  @override
  Future<void> sendPasswordReset(String email) =>
      guard(() => _supabase.auth.resetPasswordForEmail(email));

  @override
  Future<AppUser> continueAsGuest() async {
    await _prefs.setBool(_guestKey, true);
    _controller.add(AppUser.guest);
    return AppUser.guest;
  }

  @override
  Future<void> migrateGuestData(String newUserId) async {
    // Guest rows were written locally with user_id == 'local'. Re-stamp them
    // with the real uid and queue every one for upload. Implemented per feature
    // via LocalMigrator (see docs/ARCHITECTURE.md > "Guest to account").
    await _syncEngine.resetCursors();
    unawaited(_syncEngine.syncNow());
  }

  @override
  Future<void> signOut() async {
    await guard(() => _supabase.auth.signOut());
    await _prefs.setBool(_guestKey, false);
    await _syncEngine.resetCursors();
    _controller.add(null);
  }

  Future<void> dispose() async {
    await _authSub?.cancel();
    await _controller.close();
  }
}
