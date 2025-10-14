import 'package:dio/dio.dart';

class DioErrorHandler {
  static Exception handle(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return Exception('Connection timeout. Please try again later.');
      case DioExceptionType.sendTimeout:
        return Exception('Send timeout. Please try again.');
      case DioExceptionType.receiveTimeout:
        return Exception('Receive timeout. Please try again.');
      case DioExceptionType.connectionError:
        return Exception('No internet connection. Please check your network.');
      case DioExceptionType.badResponse:
        return Exception('Unexpected error occurred. Please try again.');
      case DioExceptionType.cancel:
        return Exception('Request was cancelled.');
      case DioExceptionType.unknown:
      default:
        return Exception('Unexpected error: ${e.message}');
    }
  }

  static T handleWithParser<T>(
    DioException e,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (e.type == DioExceptionType.badResponse &&
        e.response?.statusCode == 401 &&
        e.response?.data != null) {
      return fromJson(e.response!.data);
    }
    throw handle(e);
  }
}
