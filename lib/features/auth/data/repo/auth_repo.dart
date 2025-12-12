import 'package:carebox/core/network/api_helper.dart';
import 'package:carebox/core/network/api_respose.dart';
import 'package:carebox/core/network/end_points.dart';
import 'package:carebox/features/auth/data/models/basic_login_model.dart';
import 'package:carebox/features/auth/data/models/basic_response_model.dart';
import 'package:dartz/dartz.dart';

class AuthRepo {
  ApiHelper apiHelper = ApiHelper();

  Future<Either<String, String>> register({
    required String fullName,
    required String password,
    required String confirmPassword,
    required String email,
    required String phoneNumber,
  }) async {
    try {
      final response = await apiHelper.postRequest(
        endPoint: EndPoints.register,
        data: {
          'fullName': fullName,
          'password': password,
          'email': email,
          'phoneNumber': phoneNumber,
          'ConfirmPassword': confirmPassword,
        },
      );

      final basicResponseModel = BasicResponseModel.fromJson(
        response.data as Map<String, dynamic>,
      );

      // Treat non-empty message as success (quick-and-dirty)
      if (basicResponseModel.message?.isNotEmpty == true) {
        return right(basicResponseModel.message!);
      } else {
        return left(response.message ?? "حدث خطأ أثناء التسجيل");
      }
    } catch (e) {
      return left(ApiResponse.fromError(e).message);
    }
  }

  Future<Either<String, BasicLoginModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiHelper.postRequest(
        endPoint: EndPoints.login,
        data: {'email': email, 'password': password},
      );

      final loginModel = BasicLoginModel.fromJson(
        response.data as Map<String, dynamic>,
      );

      // Quick approach: treat non-empty message as success (fragile)
      if (loginModel.message?.isNotEmpty == true) {
        return right(loginModel);
      } else {
        return left(response.message ?? "فشل تسجيل الدخول");
      }
    } catch (e) {
      return left(ApiResponse.fromError(e).message);
    }
  }
}
