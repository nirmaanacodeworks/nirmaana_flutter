import 'package:flutter/material.dart';
import '../utils/responsive.dart';

class SignUpPrompt extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final String linkText;

  const SignUpPrompt({
    super.key,
    required this.onPressed,
    this.text = "Don't have an account?",
    this.linkText = "Sign Up",
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
            color: Colors.white70,
            fontSize: Responsive.safeFontSize(16),
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            linkText,
            style: TextStyle(
              color: Colors.orange.shade700,
              fontWeight: FontWeight.bold,
              fontSize: Responsive.safeFontSize(16),
            ),
          ),
        ),
      ],
    );
  }
}
