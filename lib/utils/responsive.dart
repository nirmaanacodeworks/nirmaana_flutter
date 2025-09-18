import 'package:flutter/widgets.dart';
import 'dart:math' as math;

/// Responsive utility using **pure diagonal scaling**.
///
/// 📌 No static reference device.
/// 📌 All scaling values are computed uniquely for each device.
/// 📌 Ensures a uniform proportional layout across all screen sizes.
class Responsive {
  static late double _scale;
  static late double _screenWidth;
  static late double _screenHeight;
  static late double _diagonal;

  /// Initialize responsiveness using [context].
  /// Scaling is based directly on the device’s own diagonal.
  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _screenWidth = size.width;
    _screenHeight = size.height;

    _diagonal = math.sqrt(
      _screenWidth * _screenWidth + _screenHeight * _screenHeight,
    );

    // Scale factor is normalized: diagonal / 1000
    // (so values stay in a comfortable range across devices)
    _scale = _diagonal / 1000;
  }

  // ---------------------------------------------------------------------------
  // 📏 Dimension Scaling
  // ---------------------------------------------------------------------------

  static double width(double size) => size * _scale;
  static double height(double size) => size * _scale;

  static double safeWidth(double size) => width(size).clamp(0, _screenWidth);
  static double safeHeight(double size) => height(size).clamp(0, _screenHeight);

  // ---------------------------------------------------------------------------
  // 🔠 Font Scaling
  // ---------------------------------------------------------------------------

  static double fontSize(double size) => size * _scale;

  static double safeFontSize(
    double size, {
    double min = 10.0,
    double max = 32.0,
  }) => (size * _scale).clamp(min, max);

  // ---------------------------------------------------------------------------
  // 📦 Spacing & Radius
  // ---------------------------------------------------------------------------

  static double margin(double size) => size * _scale;
  static double padding(double size) => size * _scale;
  static double radius(double size) => size * _scale;
}

// -----------------------------------------------------------------------------
// 🔢 Extension for shorthand usage
// -----------------------------------------------------------------------------

extension ResponsiveNum on num {
  /// Uniform diagonal scaling
  double get rs => this * Responsive._scale;

  /// Scaling with clamps (useful for fonts)
  double rsClamped({double min = 8, double max = 40}) =>
      (this * Responsive._scale).clamp(min, max);
}
