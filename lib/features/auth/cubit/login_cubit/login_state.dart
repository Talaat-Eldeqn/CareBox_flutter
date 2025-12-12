import 'package:carebox/features/auth/data/models/basic_login_model.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginPasswordChangedVisibility extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final BasicLoginModel loginModel;
  LoginSuccess(this.loginModel);
}

class LoginError extends LoginState {
  final String error;
  LoginError(this.error);
}
