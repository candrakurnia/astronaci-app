// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_astro/common/state_enum.dart';
import 'package:mobile_astro/presentation/widgets/alert_dialog.dart';
import 'package:mobile_astro/presentation/widgets/textfield_widget.dart';
import 'package:mobile_astro/provider/auth_provider.dart';
import 'package:mobile_astro/provider/login_provider.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  static const routeName = '/SignInScreen';
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String? _passwordErrorText;
  String? _nipText;
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Consumer<LoginProvider>(
            builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/logo_astro.png",
                        height: 150.0,
                        width: 200,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 32.0),
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          "Masuk",
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextfieldWidget(
                              obscureText: false,
                              textEditingController: _emailController,
                              textInputType: TextInputType.emailAddress,
                              hintText: "Email",
                              validator: (value) {
                                if (_nipText != null) {
                                  final error = _nipText;
                                  _nipText = null;
                                  return error;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12.0),
                            TextfieldWidget(
                              obscureText: _obscureText,
                              textEditingController: _passwordController,
                              textInputType: TextInputType.text,
                              icon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                              hintText: "Password",
                              validator: (value) {
                                if (_passwordErrorText != null) {
                                  final error = _passwordErrorText;
                                  _passwordErrorText = null;
                                  return error;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  '/ForgotScreen',
                                ),
                                child: Text(
                                  "lupa kata sandi?",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.orange[400],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            SizedBox(
                              height: 42,
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                    Colors.orange[600],
                                  ),
                                ),
                                onPressed: () {
                                  _handleLogin(context);
                                },
                                child: value.isLoadingLogin
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      )
                                    : Text(
                                        "Masuk",
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Belum punya akun?",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(width: 4.0),
                                GestureDetector(
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    '/RegisterScreen',
                                  ),
                                  child: Text(
                                    "Daftar sekarang!",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange[400],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _handleLogin(BuildContext context) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (!_formKey.currentState!.validate()) return;

    if (email.isEmpty || password.isEmpty) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text("Email dan Password tidak boleh kosong")),
      );
      return;
    }

    await loginProvider.postLogin(email, password);

    switch (loginProvider.requestState) {
      case RequestState.loaded:
        final token = loginProvider.loginModel.token;
        final name = loginProvider.loginModel.user!.username;
        if (token != null) {
          await authProvider.login(token, name ?? "");
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/HomeScreen',
            ModalRoute.withName('/'),
          );
        }
        break;

      case RequestState.empty:
        setState(() {
          _passwordErrorText = "*${loginProvider.message}";
          _nipText = "*${loginProvider.message}";
        });
        _formKey.currentState!.validate();
        break;

      case RequestState.error:
        final textError = loginProvider.message;
        showDialog(
          context: context,
          builder: (context) => MyAlertDialog(
            image: "assets/failed.png",
            title: "Sign In Failed",
            content: textError,
          ),
        );
        break;

      default:
        scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text("Terjadi kesalahan saat login")),
        );
        break;
    }
  }
}
