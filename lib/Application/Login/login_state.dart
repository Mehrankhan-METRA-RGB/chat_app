part of 'login_cubit.dart';

abstract class LoginState {
  LoginState();
}

class LoginInitialState extends LoginState {
  LoginInitialState();
}

class LoginLoading extends LoginState {
  LoginLoading();
}

class LoginLoaded extends LoginState {
  Object? user;
  LoginLoaded({this.user});
}

class LoginError extends LoginState {
  final String? error;
  LoginError({this.error});
}
