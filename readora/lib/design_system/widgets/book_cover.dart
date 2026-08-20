import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:readora/design_system/tokens/readora_colors.dart';
import 'package:readora/design_system/tokens/readora_spacing.dart';

/// A book cover with a graceful fallback.
///
/// A meaningful share of Indian and self-published editions have no cover art in
/// either metadata source, so the placeholder is a first-class state, not an
/// afterthought: initials on a tinted card, derived deterministically from the
/// title so the same book always looks the same.
class BookCover extends StatelessWidget {
  const BookCover({
    required this.title,
    this.coverUrl,
    this.width = 64,
    this.aspectRatio = 2 / 3,
    super.key,
  });

  final String title;
  final String? coverUrl;
  final double width;
  final double aspectRatio;

  double get _height => width / aspectRatio;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Radii.cover),
      child: SizedBox(
        width: width,
        height: _height,
        child: coverUrl == null || coverUrl!.isEmpty
            ? _Placeholder(title: title, width: width)
            : CachedNetworkImage(
                imageUrl: coverUrl!,
                fit: BoxFit.cover,
                fadeInDuration: Motion.fast,
                placeholder: (_, __) => _Placeholder(title: title, width: width, muted: true),
                errorWidget: (_, __, ___) => _Placeholder(title: title, width: width),
              ),
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.title, required this.width, this.muted = false});

  final String title;
  final double width;
  final bool muted;

  static const _tints = [
    ReadoraColors.brand,
    ReadoraColors.accent,
    ReadoraColors.streak,
    ReadoraColors.success,
  ];

  String get _initials {
    final words = title.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
    if (words.isEmpty) return '?';
    if (words.length == 1) return words.first.characters.take(2).toString().toUpperCase();
    return (words[0].characters.first + words[1].characters.first).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final tint = _tints[title.hashCode.abs() % _tints.length];
    return ColoredBox(
      color: tint.withValues(alpha: muted ? 0.08 : 0.18),
      child: Center(
        child: muted
            ? const SizedBox.shrink()
            : Text(
                _initials,
                style: TextStyle(
                  fontSize: width * 0.3,
                  fontWeight: FontWeight.w700,
                  color: tint,
                ),
              ),
      ),
    );
  }
}
