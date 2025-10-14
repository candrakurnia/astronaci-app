import 'package:flutter/material.dart';
import 'package:mobile_astro/api/api_service.dart';
import 'package:mobile_astro/common/state_enum.dart';
import 'package:mobile_astro/model/logout_model.dart';

class LogoutProvider extends ChangeNotifier{
  final ApiService apiService;

  LogoutProvider({required this.apiService,});

  late LogoutModel _logoutModel;
  RequestState? _requestState;
  String _message = "";
  bool isLoadingLogin = false;

  LogoutModel get logoutModel => _logoutModel;
  RequestState? get requestState => _requestState;
  String get message => _message;

  Future<dynamic> postLogout(token) async {
    try {
      _requestState = RequestState.loading;
      isLoadingLogin = true;
      notifyListeners();
      var result = await ApiService().fetchLogout(token);
      if (result.message != null) {
        _requestState = RequestState.loaded;
        isLoadingLogin = false;
        notifyListeners();
        return _logoutModel = result;
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