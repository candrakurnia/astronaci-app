// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_astro/common/state_enum.dart';
import 'package:mobile_astro/presentation/widgets/alert_dialog.dart';
import 'package:mobile_astro/presentation/widgets/textfield_widget.dart';
import 'package:mobile_astro/provider/forgot_provider.dart';
import 'package:provider/provider.dart';

class ForgotPage extends StatefulWidget {
  static const routeName = '/ForgotScreen';
  const ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  String? value;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
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
                    "Masukkan email yang terdaftar",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
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
                            _handleForgot(context);
                            // Navigator.pushNamedAndRemoveUntil(
                            //   context,
                            //   '/HomeScreen',
                            //   ModalRoute.withName('/'),
                            // );
                          },
                          child: Text(
                            "Atur ulang sandi",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleForgot(BuildContext context) async {
    final forgotProvider = Provider.of<ForgotProvider>(context, listen: false);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    final email = _emailController.text.trim();

    if (!_formKey.currentState!.validate()) return;

    if (email.isEmpty) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text("Email dan Password tidak boleh kosong")),
      );
      return;
    }

    await forgotProvider.postForgot(email);

    switch (forgotProvider.requestState) {
      case RequestState.loaded:
        showDialog(
          context: context,
          builder: (context) => MyAlertDialog(
            image: "assets/failed.png",
            title: "Forgot Password Failed",
            content: forgotProvider.message,
          ),
        );
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/HomeScreen',
          ModalRoute.withName('/'),
        );
        break;

      case RequestState.empty:
        setState(() {
          value = "*${forgotProvider.message}";
        });
        _formKey.currentState!.validate();
        break;

      case RequestState.error:
        final textError = forgotProvider.message;
        showDialog(
          context: context,
          builder: (context) => MyAlertDialog(
            image: "assets/failed.png",
            title: "Forgot Password Failed",
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
