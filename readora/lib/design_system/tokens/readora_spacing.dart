/// Spacing, radius, and blur tokens.
///
/// One 4pt scale for the whole app. A widget that needs 13 pixels of padding is
/// a widget that has not decided what it is — pick a step.
abstract final class Spacing {
  static const xxs = 2.0;
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 24.0;
  static const xxl = 32.0;
  static const xxxl = 48.0;

  /// Standard horizontal page gutter.
  static const gutter = 20.0;
}

abstract final class Radii {
  static const xs = 6.0;
  static const sm = 10.0;
  static const md = 16.0;
  static const lg = 22.0;
  static const xl = 28.0;
  static const pill = 999.0;

  /// Book covers keep a slightly tighter radius than cards so they read as objects.
  static const cover = 8.0;
}

abstract final class Blur {
  /// Backdrop blur sigma for glass surfaces. Keep the count of blurred layers
  /// on one screen low — each one costs a full-screen render pass on older
  /// Android devices.
  static const glass = 24.0;
  static const glassSubtle = 12.0;
}

/// Animation durations. Named `Motion` rather than `Durations` so it does not
/// collide with Flutter's own `Durations` class.
abstract final class Motion {
  static const fast = Duration(milliseconds: 150);
  static const normal = Duration(milliseconds: 250);
  static const slow = Duration(milliseconds: 400);
}
