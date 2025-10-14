import 'package:dio/dio.dart';
import 'package:mobile_astro/helper/dio_handler.dart';
import 'package:mobile_astro/model/forgot_password_model.dart';
import 'package:mobile_astro/model/list_user_model.dart';
import 'package:mobile_astro/model/login_model.dart';
import 'package:mobile_astro/model/logout_model.dart';
import 'package:mobile_astro/model/register_model.dart';
import 'package:mobile_astro/model/update_profile_model.dart';

class ApiService {
  static const String _baseUrl =
      "https://jesse-dilemmatical-graeme.ngrok-free.dev/api";

  final Dio dio = Dio();

  Future<LoginModel> fetchLogin(String email, String password) async {
    const String url = "$_baseUrl/login";
    try {
      final response = await dio.post(
        url,
        data: {'email': email, 'password': password},
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        return LoginModel.fromJson(response.data);
      } else {
        throw Exception('Failed to Login : ${response.statusCode}');
      }
    } on DioException catch (e) {
      return DioErrorHandler.handleWithParser<LoginModel>(
        e,
        (json) => LoginModel.fromJson(json),
      );
    }
  }

  Future<LogoutModel> fetchLogout(String token) async {
    const String url = "$_baseUrl/logout";
    try {
      final response = await dio.post(
        url,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        return LogoutModel.fromJson(response.data);
      } else {
        throw Exception('Failed to Logout : ${response.statusCode}');
      }
    } on DioException catch (e) {
      return DioErrorHandler.handleWithParser<LogoutModel>(
        e,
        (json) => LogoutModel.fromJson(json),
      );
    }
  }

  Future<RegisterModel> fetchRegister(
    String username,
    String name,
    String fullname,
    String email,
    String password,
    String confirmPass,
  ) async {
    const String url = "$_baseUrl/register";
    try {
      final response = await dio.post(
        url,
        data: {
          'username': username,
          'name': name,
          'nama_lengkap': fullname,
          'email': email,
          'password': password,
          'password_confirmation': confirmPass,
        },
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 201) {
        return RegisterModel.fromJson(response.data);
      } else {
        throw Exception('Failed to Login : ${response.statusCode}');
      }
    } on DioException catch (e) {
      return DioErrorHandler.handleWithParser<RegisterModel>(
        e,
        (json) => RegisterModel.fromJson(json),
      );
    }
  }

  Future<UpdateProfileModel> updateProfil(String fullName, String alamat, String deskripsi, String token) async {
    const String url = "$_baseUrl/profile";
    try {
      final response = await dio.put(
        url,
        data: {'nama_lengkap': fullName, 'alamat': alamat, 'deskripsi' : deskripsi},
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization" : "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        return UpdateProfileModel.fromJson(response.data);
      } else {
        throw Exception('Failed to Login : ${response.statusCode}');
      }
    } on DioException catch (e) {
      return DioErrorHandler.handleWithParser<UpdateProfileModel>(
        e,
        (json) => UpdateProfileModel.fromJson(json),
      );
    }
  }

  Future<ForgotPasswordModel> fetchForgot(String email) async {
    const String url = "$_baseUrl/forgot-password";
    try {
      final response = await dio.post(
        url,
        data: {'email': email},
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        return ForgotPasswordModel.fromJson(response.data);
      } else {
        throw Exception('Failed to Login : ${response.statusCode}');
      }
    } on DioException catch (e) {
      return DioErrorHandler.handleWithParser<ForgotPasswordModel>(
        e,
        (json) => ForgotPasswordModel.fromJson(json),
      );
    }
  }

  Future<ListUserModel> getList(String token) async {
    const String url = "$_baseUrl/users";
    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        return ListUserModel.fromJson(response.data);
      } else {
        throw Exception('Failed to Login : ${response.statusCode}');
      }
    } on DioException catch (e) {
      return DioErrorHandler.handleWithParser<ListUserModel>(
        e,
        (json) => ListUserModel.fromJson(json),
      );
    }
  }
}
