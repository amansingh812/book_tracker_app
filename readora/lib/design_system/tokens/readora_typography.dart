import 'package:flutter/material.dart';

/// Type tokens.
///
/// PLACEHOLDER. Replace the family names and sizes from the Claude Design
/// export's `colors_and_type.css`, add the font files under `assets/fonts/`,
/// and declare them in `pubspec.yaml`. Until then these fall back to the
/// platform default, which is fine for wiring up screens.
///
/// Rule: no widget constructs its own `TextStyle`. Use
/// `Theme.of(context).textTheme` or a token below.
abstract final class ReadoraType {
  /// Display/heading family — the voice of the brand.
  static const String? displayFamily = null; // e.g. 'Fraunces'

  /// UI + body family.
  static const String? bodyFamily = null; // e.g. 'Inter'

  /// Long-form reading (notes, AI answers) — optically larger, looser leading.
  static const String? readingFamily = null; // e.g. 'Literata'

  static const TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: displayFamily,
      fontSize: 34,
      height: 1.15,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.6,
    ),
    displayMedium: TextStyle(
      fontFamily: displayFamily,
      fontSize: 28,
      height: 1.2,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.4,
    ),
    headlineSmall: TextStyle(
      fontFamily: displayFamily,
      fontSize: 22,
      height: 1.25,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: TextStyle(
      fontFamily: bodyFamily,
      fontSize: 18,
      height: 1.3,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      fontFamily: bodyFamily,
      fontSize: 16,
      height: 1.35,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(fontFamily: bodyFamily, fontSize: 16, height: 1.5),
    bodyMedium: TextStyle(fontFamily: bodyFamily, fontSize: 14, height: 1.5),
    bodySmall: TextStyle(fontFamily: bodyFamily, fontSize: 12, height: 1.45),
    labelLarge: TextStyle(
      fontFamily: bodyFamily,
      fontSize: 14,
      height: 1.2,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
    ),
    labelSmall: TextStyle(
      fontFamily: bodyFamily,
      fontSize: 11,
      height: 1.2,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.6,
    ),
  );

  /// Note bodies and AI answers — the only place `readingFamily` is used.
  static const reading = TextStyle(
    fontFamily: readingFamily,
    fontSize: 16,
    height: 1.62,
  );

  /// Numerals in stat tiles: tabular so they stop jittering as they count up.
  static const stat = TextStyle(
    fontSize: 26,
    height: 1.1,
    fontWeight: FontWeight.w700,
    fontFeatures: [FontFeature.tabularFigures()],
  );
}
