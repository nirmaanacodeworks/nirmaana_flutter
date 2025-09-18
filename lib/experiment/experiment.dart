import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:provider/provider.dart';

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

/// DATA_MODEL
class ResponsiveUIData extends ChangeNotifier {
  final double baseContainerSize;
  final double baseFontSizeLarge;
  final double baseFontSizeMedium;
  final double baseFontSizeSmall;
  final double baseSpacing;
  final double baseRadius;

  ResponsiveUIData({
    this.baseContainerSize = 150.0,
    this.baseFontSizeLarge = 24.0,
    this.baseFontSizeMedium = 18.0,
    this.baseFontSizeSmall = 12.0,
    this.baseSpacing = 16.0,
    this.baseRadius = 10.0,
  });
}

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ResponsiveUIData>(
      create: (BuildContext context) => ResponsiveUIData(),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: 'Responsive Showcase',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const ResponsiveScaffold(),
        );
      },
    );
  }
}

class ResponsiveScaffold extends StatefulWidget {
  const ResponsiveScaffold({super.key});

  @override
  _ResponsiveScaffoldState createState() => _ResponsiveScaffoldState();
}

class _ResponsiveScaffoldState extends State<ResponsiveScaffold> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize Responsive utility here as context is available and stable.
    Responsive.init(context);
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUIData uiData = Provider.of<ResponsiveUIData>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Responsive UI Features')),
      body: ListView(
        padding: EdgeInsets.all(Responsive.padding(uiData.baseSpacing)),
        children: <Widget>[
          _buildSectionTitle('Dimension Scaling'),
          SizedBox(height: Responsive.height(uiData.baseSpacing / 2)),
          _FeatureCard(
            title: 'Scaled Container (width/height)',
            content: Container(
              width: Responsive.width(uiData.baseContainerSize),
              height: Responsive.height(uiData.baseContainerSize * 0.5),
              decoration: BoxDecoration(
                color: Colors.blue.withAlpha(
                  (255 * 0.7).round(),
                ), // Fix: Replaced withOpacity
                borderRadius: BorderRadius.circular(
                  Responsive.radius(uiData.baseRadius),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                'W: ${Responsive.width(uiData.baseContainerSize).toStringAsFixed(1)}\nH: ${Responsive.height(uiData.baseContainerSize * 0.5).toStringAsFixed(1)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Responsive.fontSize(uiData.baseFontSizeSmall),
                ),
              ),
            ),
          ),
          SizedBox(height: Responsive.height(uiData.baseSpacing)),
          _FeatureCard(
            title: 'Safe Scaled Container (safeWidth/safeHeight)',
            content: Container(
              // Using a very large base size to demonstrate clamping on smaller screens
              width: Responsive.safeWidth(uiData.baseContainerSize * 5),
              height: Responsive.safeHeight(uiData.baseContainerSize * 3),
              decoration: BoxDecoration(
                color: Colors.green.withAlpha(
                  (255 * 0.7).round(),
                ), // Fix: Replaced withOpacity
                borderRadius: BorderRadius.circular(
                  Responsive.radius(uiData.baseRadius),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                'Safe W: ${Responsive.safeWidth(uiData.baseContainerSize * 5).toStringAsFixed(1)}\nSafe H: ${Responsive.safeHeight(uiData.baseContainerSize * 3).toStringAsFixed(1)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Responsive.fontSize(uiData.baseFontSizeSmall),
                ),
              ),
            ),
          ),
          SizedBox(height: Responsive.height(uiData.baseSpacing * 2)),

          _buildSectionTitle('Font Scaling'),
          SizedBox(height: Responsive.height(uiData.baseSpacing / 2)),
          _FeatureCard(
            title: 'Scaled Font Size (fontSize)',
            content: Text(
              'This is a large scaled text.',
              style: TextStyle(
                fontSize: Responsive.fontSize(uiData.baseFontSizeLarge),
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: Responsive.height(uiData.baseSpacing / 2)),
          _FeatureCard(
            title: 'Safe Scaled Font Size (safeFontSize - clamped)',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'This text scales, but is clamped (min 10, max 32).',
                  style: TextStyle(
                    fontSize: Responsive.safeFontSize(
                      uiData.baseFontSizeLarge * 2,
                      min: 10.0,
                      max: 32.0,
                    ),
                    color: Colors.deepPurple,
                  ),
                ),
                Text(
                  'Current size: ${Responsive.safeFontSize(uiData.baseFontSizeLarge * 2, min: 10.0, max: 32.0).toStringAsFixed(1)}',
                  style: TextStyle(
                    fontSize: Responsive.fontSize(
                      uiData.baseFontSizeSmall * 0.8,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Responsive.height(uiData.baseSpacing * 2)),

          _buildSectionTitle('Spacing, Padding & Radius'),
          SizedBox(height: Responsive.height(uiData.baseSpacing / 2)),
          Container(
            margin: EdgeInsets.all(Responsive.margin(uiData.baseSpacing)),
            padding: EdgeInsets.all(Responsive.padding(uiData.baseSpacing)),
            decoration: BoxDecoration(
              color: Colors.orange.withAlpha(
                (255 * 0.7).round(),
              ), // Fix: Replaced withOpacity
              borderRadius: BorderRadius.circular(
                Responsive.radius(uiData.baseRadius * 2),
              ),
              border: Border.all(
                color: Colors.orange,
                width: Responsive.width(2.0),
              ),
            ),
            child: Text(
              'This container has scaled margin, padding, and border radius.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: Responsive.fontSize(uiData.baseFontSizeMedium),
              ),
            ),
          ),
          SizedBox(height: Responsive.height(uiData.baseSpacing * 2)),

          _buildSectionTitle('Shorthand Extensions (num.rs / num.rsClamped)'),
          SizedBox(height: Responsive.height(uiData.baseSpacing / 2)),
          _FeatureCard(
            title: 'Scaled using .rs extension',
            content: Container(
              width: uiData.baseContainerSize.rs,
              height: (uiData.baseContainerSize * 0.4).rs,
              decoration: BoxDecoration(
                color: Colors.red.withAlpha(
                  (255 * 0.7).round(),
                ), // Fix: Replaced withOpacity
                borderRadius: BorderRadius.circular(uiData.baseRadius.rs),
              ),
              alignment: Alignment.center,
              child: Text(
                'W: ${uiData.baseContainerSize.rs.toStringAsFixed(1)}\nH: ${(uiData.baseContainerSize * 0.4).rs.toStringAsFixed(1)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: uiData.baseFontSizeSmall.rs,
                ),
              ),
            ),
          ),
          SizedBox(height: Responsive.height(uiData.baseSpacing)),
          _FeatureCard(
            title: 'Clamped using .rsClamped extension',
            content: Text(
              'This text uses .rsClamped (min 15, max 25).',
              style: TextStyle(
                fontSize: (uiData.baseFontSizeLarge * 1.5).rsClamped(
                  min: 15.0,
                  max: 25.0,
                ),
                color: Colors.teal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: Responsive.padding(5.0)),
      child: Text(
        title,
        style: TextStyle(
          fontSize: Responsive.fontSize(20.0),
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.title, required this.content});

  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: Responsive.margin(5.0)),
      child: Padding(
        padding: EdgeInsets.all(Responsive.padding(10.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: Responsive.fontSize(16.0),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: Responsive.height(8.0)),
            content,
          ],
        ),
      ),
    );
  }
}
