import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_astro/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/SplashScreen';
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  startSplashscreen() async {
    var duration = const Duration(seconds: 3);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Timer(duration, () {
      if (authProvider.isLoggedIn) {
        Navigator.pushReplacementNamed(context, '/HomeScreen');
      } else {
        Navigator.pushReplacementNamed(context, '/SignInScreen');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startSplashscreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/logo_astro.png",
          width: 200,
          height: 250,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
