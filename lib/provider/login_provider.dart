import 'package:flutter/material.dart';
import 'package:mobile_astro/api/api_service.dart';
import 'package:mobile_astro/common/state_enum.dart';
import 'package:mobile_astro/model/login_model.dart';

class LoginProvider extends ChangeNotifier{
  final ApiService apiService;

  LoginProvider({required this.apiService,});

  late LoginModel _loginModel;
  RequestState? _requestState;
  String _message = "";
  bool isLoadingLogin = false;

  LoginModel get loginModel => _loginModel;
  RequestState? get requestState => _requestState;
  String get message => _message;

  Future<dynamic> postLogin(nip, password) async {
    try {
      _requestState = RequestState.loading;
      isLoadingLogin = true;
      notifyListeners();
      var result = await ApiService().fetchLogin(nip, password);
      if (result.user != null) {
        _requestState = RequestState.loaded;
        isLoadingLogin = false;
        notifyListeners();
        return _loginModel = result;
      } else {
        _requestState = RequestState.empty;
        isLoadingLogin = false;
        notifyListeners();
        return _message = result.message ?? "Unknown Error";
      }
    } catch (e) {
      _requestState = RequestState.error;
      isLoadingLogin = false;
      notifyListeners();
      return _message = e.toString().replaceFirst('Exception: ', '');
    }
  }
}