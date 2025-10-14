// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_astro/common/state_enum.dart';
import 'package:mobile_astro/presentation/widgets/alert_dialog.dart';
import 'package:mobile_astro/presentation/widgets/textfield_widget.dart';
import 'package:mobile_astro/provider/register_provider.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = '/RegisterScreen';
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Consumer<RegisterProvider>(
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
                          "Daftar",
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
                              textEditingController: _userNameController,
                              textInputType: TextInputType.text,
                              hintText: "Username",
                              validator: (value) {
                                if (value != null) {
                                  final error = value;
                                  value = null;
                                  return error;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12.0),
                            TextfieldWidget(
                              obscureText: false,
                              textEditingController: _nameController,
                              textInputType: TextInputType.text,
                              hintText: "Name",
                              validator: (value) {
                                if (value != null) {
                                  final error = value;
                                  value = null;
                                  return error;
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 12),
                            TextfieldWidget(
                              obscureText: false,
                              textEditingController: _fullNameController,
                              textInputType: TextInputType.text,
                              hintText: "Nama Lengkap",
                              validator: (value) {
                                if (value != null) {
                                  final error = value;
                                  value = null;
                                  return error;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12.0),
                            TextfieldWidget(
                              obscureText: false,
                              textEditingController: _emailController,
                              textInputType: TextInputType.emailAddress,
                              hintText: "Email",
                              validator: (value) {
                                if (value != null) {
                                  final error = value;
                                  value = null;
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
                                if (value != null) {
                                  final error = value;
                                  value = null;
                                  return error;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12.0),
                            TextfieldWidget(
                              obscureText: _obscureText,
                              textEditingController: _confirmPassController,
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
                              hintText: "Confirm Password",
                              validator: (value) {
                                if (value != null) {
                                  final error = value;
                                  value = null;
                                  return error;
                                }
                                return null;
                              },
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
                                  _handleRegister(context);
                                  // Navigator.pushNamedAndRemoveUntil(
                                  //   context,
                                  //   '/HomeScreen',
                                  //   ModalRoute.withName('/'),
                                  // );
                                },
                                child: value.isLoadingLogin
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      )
                                    : Text(
                                        "Register",
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
                                  "Sudah punya akun?",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(width: 4.0),
                                GestureDetector(
                                  onTap: () => Navigator.pushReplacementNamed(
                                    context,
                                    '/SignInScreen',
                                  ),
                                  child: Text(
                                    "Masuk sekarang!",
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

  void _handleRegister(BuildContext context) async {
    final registerProvider = Provider.of<RegisterProvider>(
      context,
      listen: false,
    );
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    final userName = _userNameController.text.trim();
    final name = _userNameController.text.trim();
    final fullName = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPass = _confirmPassController.text.trim();

    // if (!_formKey.currentState!.validate()) return;

    if (userName.isEmpty ||
        fullName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPass.isEmpty) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text("Data tidak boleh kosong")),
      );
      return;
    }

    await registerProvider.postRegister(
      userName,
      name,
      fullName,
      email,
      password,
      confirmPass,
    );

    switch (registerProvider.requestState) {
      case RequestState.loaded:
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/SignInScreen',
          ModalRoute.withName('/'),
        );
        break;

      case RequestState.empty:
        scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text("Ada data yang kosong")),
        );
        _formKey.currentState!.validate();
        break;

      case RequestState.error:
        final textError = registerProvider.message;
        showDialog(
          context: context,
          builder: (context) => MyAlertDialog(
            image: "assets/failed.png",
            title: "Register Failed",
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
