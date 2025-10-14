import 'package:flutter/material.dart';
import 'package:mobile_astro/api/api_service.dart';
import 'package:mobile_astro/common/state_enum.dart';
import 'package:mobile_astro/model/list_user_model.dart';

class ListUserProvider extends ChangeNotifier{
  final ApiService apiService;

  ListUserProvider({required this.apiService,});

  late ListUserModel _listUserModel;
  RequestState? _requestState;
  String _message = "";
  bool isLoadingLogin = false;

  ListUserModel get listUserModel => _listUserModel;
  RequestState? get requestState => _requestState;
  String get message => _message;


  Future<dynamic> getListUser(String token) async {
    try {
      _requestState = RequestState.loading;
      isLoadingLogin = true;
      notifyListeners();
      var result = await ApiService().getList(token);
      if (result.data != null) {
        _requestState = RequestState.loaded;
        isLoadingLogin = false;
        notifyListeners();
        return _listUserModel = result;
      } else {
        _requestState = RequestState.empty;
        isLoadingLogin = false;
        notifyListeners();
        return _message = "Terjadi Kesalahan Tidak Terduga";
      }
    } catch (e) {
      _requestState = RequestState.error;
      isLoadingLogin = false;
      notifyListeners();
      return _message = e.toString().replaceFirst('Exception: ', '');
    }
  }
}