import 'package:chat_app/Domain/Models/message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitialState());
  List<MessageModel> allMessages = [];
  sendMessage(MessageModel message) {
    allMessages.add(message);
    allMessages.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    emit(ChatLoadedState(messages: allMessages));
  }

  initialLoad() {
    emit(ChatLoadingState());
    Future.delayed(const Duration(seconds: 1));
    emit(ChatLoadedState(messages: allMessages));
  }
}
