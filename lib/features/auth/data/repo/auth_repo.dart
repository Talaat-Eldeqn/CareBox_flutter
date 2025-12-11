import 'package:carebox/features/auth/data/models/user_model.dart';
import 'package:dio/dio.dart';

class AuthRepo {
  Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    ),
  );

  register({required UserModel usermodel}) {
    print("registering.....");
  }

  login({required UserModel usermodel}) {
    print("logging in.....");
  }
}
