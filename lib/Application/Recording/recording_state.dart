part of 'recording_cubit.dart';

abstract class RecordingState {
  RecordingState();
}

class RecordInitialState extends RecordingState {
  RecordInitialState();
}

class RecordStartState extends RecordingState {
  RecordStartState();
}

class RecordPauseState extends RecordingState {
  RecordPauseState();
}

class RecordResumeState extends RecordingState {
  RecordResumeState();
}

class RecordCancelState extends RecordingState {
  RecordCancelState();
}
