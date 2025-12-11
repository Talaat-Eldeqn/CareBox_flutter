import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmController = TextEditingController();
  var userNameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  bool passwordSecure = true;

  void changePasswordVisibility() {
    passwordSecure = !passwordSecure;
    emit(ChangePasswordVisibility());
  }

  void changePasswordConfirmVisibility() {
    passwordSecure = !passwordSecure;
    emit(ChangePasswordConfirmVisibility());
  }

  void onRegisterPressed() {
    formKey.currentState!.validate();
  }
}
