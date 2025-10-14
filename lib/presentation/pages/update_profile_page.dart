// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_astro/common/state_enum.dart';
import 'package:mobile_astro/presentation/widgets/alert_dialog.dart';
import 'package:mobile_astro/presentation/widgets/textfield_widget.dart';
import 'package:mobile_astro/provider/auth_provider.dart';
import 'package:mobile_astro/provider/update_provider.dart';
import 'package:provider/provider.dart';

class UpdateProfilePage extends StatefulWidget {
  static const routeName = '/UpdateProfileScreen';
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Profile")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Consumer<UpdateProvider>(
          builder: (context, value, child) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  TextfieldWidget(
                    obscureText: false,
                    textEditingController: _fullNameController,
                    textInputType: TextInputType.text,
                    hintText: "Nama Lengkap",
                    validator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 8.0),
                  TextfieldWidget(
                    obscureText: false,
                    textEditingController: _addressController,
                    textInputType: TextInputType.text,
                    hintText: "Alamat",
                    validator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 8.0),
                  TextfieldWidget(
                    obscureText: false,
                    textEditingController: _descController,
                    textInputType: TextInputType.text,
                    hintText: "Deskripsi",
                    validator: (value) {
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
                        _handleUpdate(context);
                      },
                      child: value.isLoadingLogin
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            )
                          : Text(
                              "Update",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleUpdate(BuildContext context) async {
    final updateProvider = Provider.of<UpdateProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    final fullName = _fullNameController.text.trim();
    final alamat = _addressController.text.trim();
    final deskripsi = _descController.text.trim();

    if (!_formKey.currentState!.validate()) return;

    if (fullName.isEmpty || alamat.isEmpty || deskripsi.isEmpty) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text("fullName dan Password tidak boleh kosong"),
        ),
      );
      return;
    }

    await updateProvider.postUpdate(
      fullName,
      alamat,
      deskripsi,
      authProvider.token,
    );

    switch (updateProvider.requestState) {
      case RequestState.loaded:
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/HomeScreen',
          ModalRoute.withName('/'),
        );
        break;

      case RequestState.error:
        final textError = updateProvider.message;
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
