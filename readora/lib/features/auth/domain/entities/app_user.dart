import 'package:equatable/equatable.dart';

/// Who is using the app right now.
///
/// Readora has three identity states, and the whole app is built around the
/// fact that the first one is fully functional:
///   * [AppUser.guest]   — no account. Everything works, stored only on device.
///   * signed in         — account, cloud sync, AI.
///   * signed in + Plus  — entitlement checked server-side.
class AppUser extends Equatable {
  const AppUser({
    required this.id,
    this.email,
    this.displayName,
    this.isGuest = false,
    this.hasPlus = false,
  });

  /// The local-only identity used before sign-up. Rows created under this id are
  /// rewritten to the real uid by the guest migration on first sign-in.
  static const guest = AppUser(id: 'local', isGuest: true);

  final String id;
  final String? email;
  final String? displayName;
  final bool isGuest;
  final bool hasPlus;

  String get greetingName => displayName ?? email?.split('@').first ?? 'reader';

  AppUser copyWith({String? displayName, bool? hasPlus}) => AppUser(
        id: id,
        email: email,
        displayName: displayName ?? this.displayName,
        isGuest: isGuest,
        hasPlus: hasPlus ?? this.hasPlus,
      );

  @override
  List<Object?> get props => [id, email, displayName, isGuest, hasPlus];
}
