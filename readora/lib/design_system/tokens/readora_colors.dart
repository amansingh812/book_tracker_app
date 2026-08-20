import 'package:flutter/material.dart';

/// Colour tokens.
///
/// PLACEHOLDER VALUES. These are a faithful reading of the "Glass" direction
/// (deep indigo ground, warm paper foreground, soft translucent surfaces) but
/// they are NOT the real palette yet. Replace every value in this file from
/// `_ds/.../colors_and_type.css` in the Claude Design export — and change
/// nothing outside this file when you do. See the `readora-design` skill.
///
/// Rule: no widget anywhere may write `Color(0x...)` or `Colors.blue`. If a
/// colour is missing, add a token here.
abstract final class ReadoraColors {
  // --- brand ---------------------------------------------------------------
  static const brand = Color(0xFF5B5BD6);
  static const brandSoft = Color(0xFF8B8BEB);
  static const accent = Color(0xFFE8A33D);

  // --- semantic ------------------------------------------------------------
  static const success = Color(0xFF3FA46A);
  static const warning = Color(0xFFE0A030);
  static const danger = Color(0xFFD2544E);
  static const streak = Color(0xFFF2762E);

  // --- light ---------------------------------------------------------------
  static const lightBackground = Color(0xFFF7F5F2);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightSurfaceGlass = Color(0x99FFFFFF);
  static const lightBorder = Color(0x1A1B1A28);
  static const lightTextPrimary = Color(0xFF1B1A28);
  static const lightTextSecondary = Color(0xFF5C5A6B);
  static const lightTextTertiary = Color(0xFF8E8CA0);

  // --- dark ----------------------------------------------------------------
  static const darkBackground = Color(0xFF0E0D18);
  static const darkSurface = Color(0xFF191826);
  static const darkSurfaceGlass = Color(0x8C222033);
  static const darkBorder = Color(0x1FFFFFFF);
  static const darkTextPrimary = Color(0xFFF4F2FA);
  static const darkTextSecondary = Color(0xFFB6B3C6);
  static const darkTextTertiary = Color(0xFF7E7B93);

  /// Ambient gradient painted behind the glass surfaces on Home.
  static const lightAmbient = [Color(0xFFEDE9FE), Color(0xFFF7F5F2), Color(0xFFFDF1E3)];
  static const darkAmbient = [Color(0xFF1A1533), Color(0xFF0E0D18), Color(0xFF1B1220)];
}
