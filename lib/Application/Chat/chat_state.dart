part of 'chat_cubit.dart';

abstract class ChatState {
  // final List<MessageModel>? messages;
  ChatState();
}

class ChatInitialState extends ChatState {
  ChatInitialState();
  // TODO: implement messages
  // List<MessageModel>? get initialMessages => super.messages;
}

class ChatLoadingState extends ChatState {
  ChatLoadingState();
}

class ChatLoadedState extends ChatState {
  final List<MessageModel>? messages;
  ChatLoadedState({this.messages});
}

class ChatSendState extends ChatState {
  ChatSendState();
}
