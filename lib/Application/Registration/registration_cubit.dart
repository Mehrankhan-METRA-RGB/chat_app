import 'package:chat_app/Data/Repositories/AuthRepository/auth_repository.dart';
import 'package:chat_app/Data/Repositories/Notification/notification_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationInitialState());

  Future<void> register(Map<String, dynamic> user) async {
    emit(RegistrationLoading());
    await AuthRepository.signUp(user).then((res) async {
      if (res['success']) {
        emit(RegistrationLoaded());
        await NotificationRepository().showNotification(
            90,
            'Registration Successful',
            'New user has been Registered Successfully',
            payload: 'Registration');
      } else {
        emit(RegistrationError(error: res['error']));
        await Future.delayed(const Duration(seconds: 5));
        emit(RegistrationInitialState());
      }
    });
  }
}
