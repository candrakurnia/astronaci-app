import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final String tokenKey = 'token';
  final String stateKey = 'state';
  final String nameKey = 'name';

  Future<bool> isLoggedIn() async {
    final pref = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(milliseconds: 500));
    return pref.getBool(stateKey) ?? false;
  }

  Future<void> setLoggedIn(bool value) async {
    final pref = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(milliseconds: 500));
    await pref.setBool(stateKey, value);
  }

  Future<void> saveToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(tokenKey, token);
  }

  Future<String?> getToken() async {
    final pref = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(milliseconds: 500));
    return pref.getString(tokenKey);
  }

  Future<void> saveName(String name) async {
    final pref = await SharedPreferences.getInstance();
    // await Future.delayed(const Duration(milliseconds: 500));
    await pref.setString(nameKey, name);
  }

  Future<String?> getName() async {
    final pref = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(milliseconds: 500));
    return pref.getString(nameKey);
  }

  Future<void> clearAll() async {
    final pref = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(milliseconds: 500));
    await pref.clear();
  }
}
