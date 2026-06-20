import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/quiz_provider.dart';

class BuddyWidget extends ConsumerWidget {
  const BuddyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(quizProvider);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: 180,
      width: 180,
      decoration: BoxDecoration(
        color: quizState.completed
            ? const Color(0xFFE8F5E9)
            : const Color(0xFFF0EEF7),
        borderRadius: BorderRadius.circular(24),
        boxShadow: quizState.completed
            ? [
                BoxShadow(
                  color: Colors.green.withValues(alpha: 0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ]
            : [],
      ),
      child: Center(
        child: AnimatedScale(
          duration: const Duration(milliseconds: 400),
          scale: quizState.completed ? 1.15 : 1.0,
          child: Icon(
            quizState.completed
                ? Icons.sentiment_very_satisfied
                : Icons.smart_toy_rounded,
            size: 100,
            color: quizState.completed
                ? Colors.green
                : const Color(0xFF6F2BC2),
          ),
        ),
      ),
    );
  }
}