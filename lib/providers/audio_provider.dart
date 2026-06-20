// import 'package:flutter_riverpod/flutter_riverpod.dart';

// enum AudioStatus {
//   idle,
//   loading,
//   speaking,
//   completed,
//   error,
// }

// class AudioNotifier extends StateNotifier<AudioStatus> {
//   AudioNotifier() : super(AudioStatus.idle);

//   void setLoading() {
//     state = AudioStatus.loading;
//   }

//   void setSpeaking() {
//     state = AudioStatus.speaking;
//   }

//   void setCompleted() {
//     state = AudioStatus.completed;
//   }

//   void setError() {
//     state = AudioStatus.error;
//   }
// }

// final audioProvider =
//     StateNotifierProvider<AudioNotifier, AudioStatus>(
//   (ref) => AudioNotifier(),
// );








import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AudioStatus {
  idle,
  loading,
  speaking,
  completed,
  error,
}

class AudioNotifier extends StateNotifier<AudioStatus> {
  AudioNotifier() : super(AudioStatus.idle);

  void setLoading() => state = AudioStatus.loading;

  void setSpeaking() => state = AudioStatus.speaking;

  void setCompleted() => state = AudioStatus.completed;

  void setError() => state = AudioStatus.error;

  void reset() => state = AudioStatus.idle;
}

final audioProvider =
    StateNotifierProvider<AudioNotifier, AudioStatus>(
  (ref) => AudioNotifier(),
);