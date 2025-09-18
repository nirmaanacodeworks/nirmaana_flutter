import 'package:flutter/material.dart';
import '../utils/responsive.dart';

class Header extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const Header({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: Responsive.height(100)),
        SizedBox(height: Responsive.height(40)),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: Responsive.safeFontSize(36),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: Responsive.height(10)),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.white70,
            fontSize: Responsive.safeFontSize(18),
          ),
        ),
        SizedBox(height: Responsive.height(50)),
      ],
    );
  }
}
