import 'package:flutter/foundation.dart';
import 'package:mobile_astro/api/api_service.dart';
import 'package:mobile_astro/common/state_enum.dart';
import 'package:mobile_astro/model/update_profile_model.dart';

class UpdateProvider extends ChangeNotifier{
  final ApiService apiService;

  UpdateProvider({required this.apiService,});

  late UpdateProfileModel _updateProfileModel;
  RequestState? _requestState;
  String _message = "";
  bool isLoadingLogin = false;

  UpdateProfileModel get updateProfileModel => _updateProfileModel;
  RequestState? get requestState => _requestState;
  String get message => _message;

  Future<dynamic> postUpdate(fullname, alamat, password, token) async {
    try {
      _requestState = RequestState.loading;
      isLoadingLogin = true;
      notifyListeners();
      var result = await ApiService().updateProfil(fullname, alamat, password, token);
      if (result.success == true) {
        _requestState = RequestState.loaded;
        isLoadingLogin = false;
        notifyListeners();
        return _updateProfileModel = result;
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