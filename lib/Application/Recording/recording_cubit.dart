import 'package:flutter_bloc/flutter_bloc.dart';

part 'recording_state.dart';

class RecordingCubit extends Cubit<RecordingState> {
  RecordingCubit() : super(RecordInitialState());
}
