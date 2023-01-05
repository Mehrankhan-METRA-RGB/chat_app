part of 'registration_cubit.dart';

abstract class RegistrationState {
  RegistrationState();
}

class RegistrationInitialState extends RegistrationState {
  RegistrationInitialState();
}

class RegistrationLoading extends RegistrationState {
  RegistrationLoading();
}

class RegistrationLoaded extends RegistrationState {
  Object? user;
  RegistrationLoaded({this.user});
}

class RegistrationError extends RegistrationState {
  final String? error;
  RegistrationError({this.error});
}
