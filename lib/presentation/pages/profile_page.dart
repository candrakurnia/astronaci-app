// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_astro/common/state_enum.dart';
import 'package:mobile_astro/presentation/widgets/alert_dialog.dart';
import 'package:mobile_astro/provider/auth_provider.dart';
import 'package:mobile_astro/provider/logout_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/ProfileScreen';
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                maxRadius: 60,
                backgroundImage: NetworkImage(
                  "https://res.cloudinary.com/dotz74j1p/raw/upload/v1716044979/nr7gt66alfhmu9vaxu2u.png",
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              "Candra Kurnia",
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    spreadRadius: 2,
                    color: Colors.grey,
                    offset: Offset(1, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    leading: const Icon(Icons.settings, size: 24.0),
                    title: Text(
                      "Pengaturan",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Divider(thickness: 2),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/UpdateProfileScreen');
                    },
                    child: ListTile(
                      leading: const Icon(Icons.person_add, size: 24.0),
                      title: Text(
                        "Ubah Profil",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Divider(thickness: 2),
                  ListTile(
                    leading: const Icon(Icons.person, size: 24.0),
                    title: Text(
                      "Profile Saya",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Consumer<LogoutProvider>(
              builder: (context, value, child) => SizedBox(
                height: 45,
                width: 250,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.orange[600]),
                  ),
                  onPressed: () {
                    _handleLogout(context);
                  },
                  child: value.isLoadingLogin
                      ? CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        )
                      : Text(
                          "Keluar",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleLogout(BuildContext context) async {
    final logoutProvider = Provider.of<LogoutProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    await logoutProvider.postLogout(authProvider.token);

    switch (logoutProvider.requestState) {
      case RequestState.loaded:
        final token = authProvider.token;
        if (token != null) {
          await authProvider.logout();
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/HomeScreen',
            ModalRoute.withName('/'),
          );
        }
        break;

      case RequestState.empty:
        scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text("Terjadi Kesalahan tak terduga")),
        );
        break;

      case RequestState.error:
        final textError = logoutProvider.message;
        showDialog(
          context: context,
          builder: (context) => MyAlertDialog(
            image: "assets/failed.png",
            title: "Sign Out Failed",
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
