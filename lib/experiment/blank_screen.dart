import 'package:flutter/material.dart';
import '../utils/responsive.dart';

/// A blank responsive canvas screen.
///
/// - Works as a starting point to design anything.
/// - Automatically scales with any screen size using diagonal scaling.
/// - You can pass a [color] to change the canvas background.
class BlankScreen extends StatelessWidget {
  final Color color;

  const BlankScreen({
    super.key,
    this.color = Colors.white, // default canvas color
  });

  @override
  Widget build(BuildContext context) {
    // Initialize Responsive utility (diagonal-based)
    Responsive.init(context);

    return Scaffold(
      backgroundColor: color,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Responsive.height(48)),
        child: Container(
          color: Colors.purple,
          alignment: Alignment.center,
          child: Text(
            "Blank Canvas",
            style: TextStyle(
              fontSize: Responsive.safeFontSize(20),
              color: Colors.white,
            ),
          ),
        ),
      ),

      body: Center(
        child: Container(
          width: Responsive.width(480),
          height: Responsive.height(720),
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(Responsive.radius(32)),
          ),
          alignment: Alignment.center,
          child: Text(
            "Start Designing Here 🎨",
            style: TextStyle(
              fontSize: Responsive.safeFontSize(16),
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
