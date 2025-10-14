import 'package:flutter/material.dart';

class TextfieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final bool obscureText;
  final String hintText;
  final Widget? icon;
  final String? Function(String?)? validator;
  const TextfieldWidget({
    super.key,
    required this.obscureText,
    required this.textEditingController,
    this.icon,
    required this.textInputType,
    required this.hintText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      obscureText: obscureText,
      keyboardType: textInputType,
      decoration: InputDecoration(
        errorMaxLines: 2,
        errorStyle: const TextStyle(fontSize: 12),
        suffixIcon: icon,
        hintText: hintText,
        hintStyle: const TextStyle(fontWeight: FontWeight.w400),
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Colors.blueGrey),
        ),
      ),
      validator: validator,
    );
  }
}
