import 'package:chat_app/Data/Repositories/AuthRepository/auth_repository.dart';
import 'package:chat_app/Data/Repositories/Notification/notification_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  Future<void> login(email, password) async {
    emit(LoginLoading());
    await AuthRepository.signIn(email, password).then((res) async {
      if (res['success']) {
        emit(LoginLoaded());
        await NotificationRepository().showNotification(
            90, 'Logged In', 'New user has been logged In',
            payload: 'Login');
      } else {
        emit(LoginError(error: res['error']));
        await Future.delayed(const Duration(seconds: 5));
        emit(LoginInitialState());
      }
    });
  }
}
