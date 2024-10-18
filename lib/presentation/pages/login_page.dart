import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tody_app/bloc/login/login_notifier.dart';
import 'package:tody_app/bloc/login/login_state.dart';
import 'package:tody_app/core/constants/routes.dart';
import 'package:tody_app/presentation/widgets/app_action_button.dart';
import 'package:tody_app/core/theme/theme_ext.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();

    context.read<LoginNotifier>().addListener(
      () {
        final loginNotifier = context.read<LoginNotifier>();
        final loginState = loginNotifier.loginState;
        if (loginState is SuccessState) {
          Navigator.of(context).pushReplacementNamed(EnumRoutes.home.path);
        } else if (loginState is ErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                loginState.errorMessage,
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginState = context.watch<LoginNotifier>().loginState;

    final border = OutlineInputBorder(
      borderSide: BorderSide(
        color: context.colors.onPrimary,
      ),
    );

    final errorBorder = border.copyWith(
      borderSide: const BorderSide(color: Colors.redAccent),
    );

    return Scaffold(
      backgroundColor: context.colors.surface,
      appBar: AppBar(
        backgroundColor: context.colors.surface,
        title: Center(
          child: Text(
            'Login',
            style: context.typography.displaySmall,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  enabledBorder: border,
                  focusedBorder: border,
                  errorBorder: errorBorder,
                  focusedErrorBorder: errorBorder,
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username is required';
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
              if (loginState is LoadingState)
                const CircularProgressIndicator()
              else
                AppActionButton(
                  title: 'Login',
                  onPressed: () {
                    _formKey.currentState!.save();
                    if (_formKey.currentState!.validate()) {
                      context.read<LoginNotifier>().login(
                            username: _usernameController.text.trim(),
                            password: _passwordController.text.trim(),
                          );
                    }
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
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
