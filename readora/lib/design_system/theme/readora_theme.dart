import 'package:flutter/material.dart';
import 'package:readora/design_system/tokens/readora_colors.dart';
import 'package:readora/design_system/tokens/readora_spacing.dart';
import 'package:readora/design_system/tokens/readora_typography.dart';

/// Builds the two ThemeData objects from the tokens.
///
/// Nothing else in the app calls `ThemeData(...)`. If a component needs a
/// colour or a shape, it comes from `Theme.of(context)` or from a token.
abstract final class ReadoraTheme {
  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    final scheme = ColorScheme(
      brightness: brightness,
      primary: ReadoraColors.brand,
      onPrimary: Colors.white,
      primaryContainer: isDark ? ReadoraColors.brand.withValues(alpha: 0.24) : ReadoraColors.brandSoft,
      onPrimaryContainer: isDark ? ReadoraColors.darkTextPrimary : ReadoraColors.lightTextPrimary,
      secondary: ReadoraColors.accent,
      onSecondary: Colors.white,
      error: ReadoraColors.danger,
      onError: Colors.white,
      surface: isDark ? ReadoraColors.darkSurface : ReadoraColors.lightSurface,
      onSurface: isDark ? ReadoraColors.darkTextPrimary : ReadoraColors.lightTextPrimary,
      onSurfaceVariant: isDark ? ReadoraColors.darkTextSecondary : ReadoraColors.lightTextSecondary,
      outline: isDark ? ReadoraColors.darkBorder : ReadoraColors.lightBorder,
    );

    final textTheme = ReadoraType.textTheme.apply(
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor:
          isDark ? ReadoraColors.darkBackground : ReadoraColors.lightBackground,
      textTheme: textTheme,
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
      ),
      cardTheme: CardThemeData(
        color: isDark ? ReadoraColors.darkSurface : ReadoraColors.lightSurface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.md),
          side: BorderSide(color: scheme.outline),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.md)),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          side: BorderSide(color: scheme.outline),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.md)),
          textStyle: textTheme.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? ReadoraColors.darkSurface : ReadoraColors.lightSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Spacing.lg,
          vertical: Spacing.lg,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radii.md),
          borderSide: BorderSide(color: scheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radii.md),
          borderSide: BorderSide(color: scheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radii.md),
          borderSide: const BorderSide(color: ReadoraColors.brand, width: 1.5),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        indicatorColor: ReadoraColors.brand.withValues(alpha: 0.16),
        labelTextStyle: WidgetStatePropertyAll(textTheme.labelSmall),
      ),
      dividerTheme: DividerThemeData(color: scheme.outline, thickness: 1, space: 1),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.sm)),
      ),
    );
  }
}
