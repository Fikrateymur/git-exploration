import 'package:flutter/material.dart';
import 'package:tody_app/core/app_colors.dart';
import 'package:tody_app/presentation/widgets/app_action_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.onPrimary,
      ),
    );

    final errorBorder = border.copyWith(
      borderSide: const BorderSide(color: Colors.redAccent),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Login'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  enabledBorder: border,
                  focusedBorder: border,
                  errorBorder: errorBorder,
                  focusedErrorBorder: errorBorder,
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is reuired';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  enabledBorder: border,
                  focusedBorder: border,
                  errorBorder: errorBorder,
                  focusedErrorBorder: errorBorder,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 6) {
                    return 'Password is required and must be at least 6 characters';
                  }
                  return null;
                },
                obscureText: !_isPasswordVisible,
                obscuringCharacter: '*',
              ),
              const SizedBox(height: 56),
              AppActionButton(
                title: 'Login',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final email = _emailController.text;
                    final password = _passwordController.text;

                    print('Email: ${email} Password ${password}');
                  }
                  ;
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
