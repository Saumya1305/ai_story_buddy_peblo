import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_colors.dart';
import '../models/quiz_model.dart';
import '../providers/quiz_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

class QuizCard extends ConsumerStatefulWidget {
  final QuizModel quiz;

  const QuizCard({
    super.key,
    required this.quiz,
  });

  @override
  ConsumerState<QuizCard> createState() =>
      _QuizCardState();
}

class _QuizCardState
    extends ConsumerState<QuizCard> {
  late ConfettiController
      _confettiController;

  @override
  void initState() {
    super.initState();

    _confettiController =
        ConfettiController(
      duration:
          const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quizState =
        ref.watch(quizProvider);

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ConfettiWidget(
          confettiController:
              _confettiController,
          blastDirectionality:
              BlastDirectionality
                  .explosive,
          shouldLoop: false,
          emissionFrequency: 0.08,
          numberOfParticles: 80,
          maxBlastForce: 35,
          minBlastForce: 20,
        ),

        Container(
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(24),
    border: Border.all(
      color: AppColors.cardBorder,
    ),
  ),
  child: Column(
    crossAxisAlignment:
        CrossAxisAlignment.start,
    children: [
      Text(
        widget.quiz.question,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      const SizedBox(height: 20),

      ...widget.quiz.options.map(
        (option) => Padding(
          padding: const EdgeInsets.only(
            bottom: 12,
          ),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: quizState.completed
                  ? null
                  : () {
                      if (option ==
                          widget.quiz.answer) {
                        _confettiController
                            .play();
                      }

                      if (option !=
                          widget.quiz.answer) {
                        HapticFeedback
                            .mediumImpact();
                      }

                      ref
                          .read(
                            quizProvider
                                .notifier,
                          )
                          .checkAnswer(
                            option,
                            widget.quiz.answer,
                          );
                    },
              child: Text(option),
            ),
          ),
        ),
      ),

      if (quizState.showSuccess)
        const Padding(
          padding: EdgeInsets.only(
            top: 20,
          ),
          child: Column(
            children: [
              Text(
                "🎉 Great Job!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight:
                      FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Pip found his blue gear!",
                textAlign:
                    TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),

      if (quizState.wrongAnswer &&
          !quizState.completed)
        const Padding(
          padding: EdgeInsets.only(
            top: 16,
          ),
          child: Text(
            "Try Again 😊",
            style: TextStyle(
              fontSize: 18,
              color: Colors.red,
            ),
          ),
        ),
    ],
  ),
)
    .animate(
      target:
          quizState.wrongAnswer
              ? 1
              : 0,
    )
    .shake(
      duration: 500.ms,
    ),
      ],
    ); 
  } 
}