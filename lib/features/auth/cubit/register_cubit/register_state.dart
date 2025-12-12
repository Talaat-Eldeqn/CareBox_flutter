abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterPasswordChangedVisibility extends RegisterState {}

class RegisterConfirmPasswordChangedVisibility extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final String msg;
  RegisterSuccess(this.msg);
}

class RegisterError extends RegisterState {
  final String error;
  RegisterError(this.error);
}
