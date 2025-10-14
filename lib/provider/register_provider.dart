import 'package:flutter/material.dart';
import 'package:mobile_astro/api/api_service.dart';
import 'package:mobile_astro/common/state_enum.dart';
import 'package:mobile_astro/model/register_model.dart';

class RegisterProvider extends ChangeNotifier {
  final ApiService apiService;

  RegisterProvider({required this.apiService});

  late RegisterModel _registerModel;
  RequestState? _requestState;
  String _message = "";
  bool isLoadingLogin = false;

  RegisterModel get registerModel => _registerModel;
  RequestState? get requestState => _requestState;
  String get message => _message;

  Future<dynamic> postRegister(
    userName,
    name,
    fullName,
    email,
    password,
    confirmPass,
  ) async {
    try {
      _requestState = RequestState.loading;
      isLoadingLogin = true;
      notifyListeners();
      var result = await ApiService().fetchRegister(
        userName,
        name,
        fullName,
        email,
        password,
        confirmPass,
      );
      if (result.user != null) {
        _requestState = RequestState.loaded;
        isLoadingLogin = false;
        notifyListeners();
        return _registerModel = result;
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
