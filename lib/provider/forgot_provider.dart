import 'package:flutter/material.dart';
import 'package:mobile_astro/api/api_service.dart';
import 'package:mobile_astro/common/state_enum.dart';
import 'package:mobile_astro/model/forgot_password_model.dart';

class ForgotProvider extends ChangeNotifier{
  final ApiService apiService;

  ForgotProvider({required this.apiService,});

  late ForgotPasswordModel _forgotPasswordModel;
  RequestState? _requestState;
  String _message = "";
  bool isLoadingLogin = false;

  ForgotPasswordModel get forgotPasswordModel => _forgotPasswordModel;
  RequestState? get requestState => _requestState;
  String get message => _message;


  Future<dynamic> postForgot(String email) async {
    try {
      _requestState = RequestState.loading;
      isLoadingLogin = true;
      notifyListeners();
      var result = await ApiService().fetchForgot(email);
      if (result.success == true) {
        _requestState = RequestState.loaded;
        isLoadingLogin = false;
        notifyListeners();
        return _forgotPasswordModel = result;
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