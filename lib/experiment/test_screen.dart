import 'package:flutter/material.dart';
import 'blank_screen.dart';

/// TestScreen now just opens the BlankScreen directly.
class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BlankScreen(
      color: Colors.white, // 👈 change canvas color here
    );
  }
}
