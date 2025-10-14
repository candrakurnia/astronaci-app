import 'package:flutter/material.dart';
import 'package:mobile_astro/api/api_service.dart';
import 'package:mobile_astro/db/auth_repository.dart';
import 'package:mobile_astro/model/list_user_model.dart';
import 'package:mobile_astro/presentation/pages/detail_page.dart';
import 'package:mobile_astro/presentation/pages/forgot_page.dart';
import 'package:mobile_astro/presentation/pages/home_page.dart';
import 'package:mobile_astro/presentation/pages/profile_page.dart';
import 'package:mobile_astro/presentation/pages/register_page.dart';
import 'package:mobile_astro/presentation/pages/sign_in_page.dart';
import 'package:mobile_astro/presentation/pages/splash_page.dart';
import 'package:mobile_astro/presentation/pages/update_profile_page.dart';
import 'package:mobile_astro/provider/auth_provider.dart';
import 'package:mobile_astro/provider/forgot_provider.dart';
import 'package:mobile_astro/provider/list_user_provider.dart';
import 'package:mobile_astro/provider/login_provider.dart';
import 'package:mobile_astro/provider/logout_provider.dart';
import 'package:mobile_astro/provider/register_provider.dart';
import 'package:mobile_astro/provider/update_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RegisterProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(authRepository: AuthRepository()),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (context) => UpdateProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (context) => ForgotProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (context) => ListUserProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (context) => LogoutProvider(apiService: ApiService()),
        ),
      ],
      child: MaterialApp(
        title: 'Mobile Astro',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: SplashPage.routeName,
        routes: {
          SplashPage.routeName: (context) => const SplashPage(),
          SignInPage.routeName: (context) => const SignInPage(),
          RegisterPage.routeName: (context) => const RegisterPage(),
          ForgotPage.routeName: (context) => const ForgotPage(),
          HomePage.routeName: (context) => const HomePage(),
          ProfilePage.routeName: (context) => const ProfilePage(),
          UpdateProfilePage.routeName: (context) => const UpdateProfilePage(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == DetailPage.routeName) {
            final data = settings.arguments as Datum;
            return MaterialPageRoute(
              builder: (context) => DetailPage(data: data),
            );
          }
          return null;
        },
      ),
    );
  }
}
