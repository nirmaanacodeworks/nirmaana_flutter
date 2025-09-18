import 'package:flutter/material.dart';
import '../utils/responsive.dart';

class AuthInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;

  const AuthInputField({
    super.key,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: TextStyle(
        color: Colors.white,
        fontSize: Responsive.safeFontSize(16),
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white54,
          fontSize: Responsive.safeFontSize(16),
        ),
        prefixIcon: Icon(icon, color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withAlpha((255 * 0.1).round()),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Responsive.radius(12)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Responsive.radius(12)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Responsive.radius(12)),
          borderSide: BorderSide(
            color: Colors.orange.shade700,
            width: Responsive.width(2),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: Responsive.padding(15),
          horizontal: Responsive.padding(15),
        ),
      ),
    );
  }
}
