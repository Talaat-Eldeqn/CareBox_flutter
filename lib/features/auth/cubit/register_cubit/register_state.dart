class RegisterState {}

class RegisterInitial extends RegisterState {}


class ChangePasswordVisibility extends RegisterState {}
class ChangePasswordConfirmVisibility extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFailure extends RegisterState {
  final String message;

  RegisterFailure({required this.message});
}
