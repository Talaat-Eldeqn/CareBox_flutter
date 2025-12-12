import 'package:carebox/features/auth/data/repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);

  final fullName = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool passwordSecure = true;
  bool confirmPasswordSecure = true;

  void changePasswordSecure() {
    passwordSecure = !passwordSecure;
    emit(RegisterPasswordChangedVisibility());
  }

  void changeConfirmPasswordSecure() {
    confirmPasswordSecure = !confirmPasswordSecure;
    emit(RegisterConfirmPasswordChangedVisibility());
  }

  Future<void> onRegisterPressed() async {
    // Prevent double submissions
    if (state is RegisterLoading) return;

    // Validate form local fields first
    if (formKey.currentState?.validate() != true) return;

    // Check passwords match before making network call
    if (password.text != confirmPassword.text) {
      emit(RegisterError("كلمتا المرور غير متطابقتين"));
      return;
    }

    emit(RegisterLoading());

    final repo = AuthRepo();

    final result = await repo.register(
      fullName: fullName.text.trim(),
      password: password.text,
      email: email.text.trim(),
      phoneNumber: phoneNumber.text.trim(),
      confirmPassword: confirmPassword.text,
    );

    result.fold(
      (String error) => emit(RegisterError(error)),
      (String message) => emit(RegisterSuccess(message)),
    );
  }

  @override
  Future<void> close() {
    // Dispose controllers to avoid memory leaks
    fullName.dispose();
    password.dispose();
    confirmPassword.dispose();
    email.dispose();
    phoneNumber.dispose();
    return super.close();
  }
}
