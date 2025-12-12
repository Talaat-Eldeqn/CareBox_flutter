import 'package:carebox/features/auth/data/models/basic_login_model.dart';
import 'package:carebox/features/auth/data/repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool passwordSecure = true;

  void changePasswordSecure() {
    passwordSecure = !passwordSecure;
    emit(LoginPasswordChangedVisibility());
  }

  Future<void> onLoginPressed() async {
    if (formKey.currentState?.validate() != true) return;

    emit(LoginLoading());

    final AuthRepo repo = AuthRepo();
    final result = await repo.login(
      email: email.text.trim(),
      password: password.text,
    );

    result.fold(
      (String error) => emit(LoginError(error)),
      (BasicLoginModel loginModel) => emit(LoginSuccess(loginModel)),
    );
  }
}
