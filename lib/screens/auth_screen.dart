import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/responsive.dart';
import '../viewmodels/auth_view_model.dart';
import '../components/auth_input_field.dart';
import '../components/loading_button.dart';
import '../components/header.dart';
import '../components/signup_prompt.dart';
import '../utils/colors.dart';
import '../utils/spacing.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: Responsive.padding(30)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Header(
                icon: Icons.lock_person,
                title: 'Welcome Back!',
                subtitle: 'Log in to your account',
              ),
              SizedBox(height: AppSpacing.s40),

              AuthInputField(
                hintText: 'Email',
                icon: Icons.email,
                onChanged: (val) => context.read<AuthViewModel>().setEmail(val),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: AppSpacing.s20),

              AuthInputField(
                hintText: 'Password',
                icon: Icons.lock,
                obscureText: true,
                onChanged: (val) =>
                    context.read<AuthViewModel>().setPassword(val),
              ),
              SizedBox(height: AppSpacing.s15),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () =>
                      context.read<AuthViewModel>().forgotPassword(),
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: Responsive.safeFontSize(14),
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppSpacing.s30),

              Consumer<AuthViewModel>(
                builder: (context, authVM, _) {
                  return LoadingButton(
                    text: 'LOGIN',
                    isLoading: authVM.isLoading,
                    onPressed: () => authVM.login(),
                  );
                },
              ),
              SizedBox(height: AppSpacing.s30),

              SignUpPrompt(
                onPressed: () =>
                    context.read<AuthViewModel>().navigateToSignUp(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
