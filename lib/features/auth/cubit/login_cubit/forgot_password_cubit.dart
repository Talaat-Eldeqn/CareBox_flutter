import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitial());

  static ForgotPasswordCubit get(context) => BlocProvider.of(context);


  var emailController = TextEditingController();


  var formKey = GlobalKey<FormState>();



  void onSendCodePressed(){

  formKey.currentState!.validate();

  }
}