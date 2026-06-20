import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizState {
  final bool visible;
  final bool completed;
  final String? selectedAnswer;
  final bool wrongAnswer;
  final bool showSuccess;

  const QuizState({
    this.visible = false,
    this.completed = false,
    this.selectedAnswer,
    this.wrongAnswer = false,
    this.showSuccess = false,
  });

  QuizState copyWith({
    bool? visible,
    bool? completed,
    String? selectedAnswer,
    bool? wrongAnswer,
    bool? showSuccess,
  }) {
    return QuizState(
      visible: visible ?? this.visible,
      completed: completed ?? this.completed,
      selectedAnswer:
          selectedAnswer ?? this.selectedAnswer,
      wrongAnswer:
          wrongAnswer ?? this.wrongAnswer,
      showSuccess:
          showSuccess ?? this.showSuccess,
    );
  }
}

class QuizNotifier extends StateNotifier<QuizState> {
  QuizNotifier() : super(const QuizState());

  void showQuiz() {
    state = state.copyWith(
      visible: true,
    );
  }

  void checkAnswer(
    String selected,
    String correctAnswer,
  ) {
    if (state.completed) return;

    if (selected == correctAnswer) {
      state = state.copyWith(
        selectedAnswer: selected,
        completed: true,
        wrongAnswer: false,
        showSuccess: true,
      );
    } else {
      state = state.copyWith(
        selectedAnswer: selected,
        wrongAnswer: true,
      );
    }
  }

  void clearWrongState() {
    state = state.copyWith(
      wrongAnswer: false,
    );
  }

  void reset() {
    state = const QuizState();
  }
}

final quizProvider =
    StateNotifierProvider<QuizNotifier, QuizState>(
  (ref) => QuizNotifier(),
);