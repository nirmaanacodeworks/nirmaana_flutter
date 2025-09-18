import 'package:flutter/material.dart';
import '../screens/test_screen.dart';

void main() {
  runApp(const MyApp());
}

/// Root widget of the app.
/// Starts with [TestScreen] to demo responsive.dart features.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TestScreen(),
    );
  }
}
