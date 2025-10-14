import 'package:flutter/material.dart';
import 'package:mobile_astro/db/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository authRepository;

  bool _isLoggedIn = false;
  String? _token;
  String? _name;

  bool get isLoggedIn => _isLoggedIn;
  String? get token => _token;
  String? get name => _name;

  AuthProvider({required this.authRepository}) {
    _loadAuthState();
  }

  Future<void> _loadAuthState() async {
    _isLoggedIn = await authRepository.isLoggedIn();
    _token = await authRepository.getToken();
    _name = await authRepository.getName();
    notifyListeners();
  }

  Future<void> login(String token, String name) async {
    await authRepository.setLoggedIn(true);
    await authRepository.saveToken(token);
    await authRepository.saveName(name);
    _isLoggedIn = true;
    _token = token;
    _name = name;
    notifyListeners();
  }

  Future<void> logout() async {
    await authRepository.clearAll();
    _isLoggedIn = false;
    _token = null;
    _name = null;
    notifyListeners();
  }
}
