import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_colors.dart';
import '../providers/audio_provider.dart';
import '../widgets/buddy_widget.dart';
import '../widgets/story_button.dart';
import '../widgets/story_card.dart';
import '../constants/app_strings.dart';
import '../providers/quiz_provider.dart';
import '../providers/tts_provider.dart';
import '../data/quiz_data.dart';
import '../models/quiz_model.dart';
import '../widgets/quiz_card.dart';


class StoryScreen extends ConsumerWidget {
  const StoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioStatus = ref.watch(audioProvider);
    final quiz =
    QuizModel.fromJson(quizJson);

final quizState =
    ref.watch(quizProvider);
    if (audioStatus == AudioStatus.error) {
    return Scaffold(
      backgroundColor:
          AppColors.background,
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 80,
                color: Colors.red,
              ),

              const SizedBox(height: 20),

              const Text(
                "Oops! 🤖",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                "Pip couldn't tell the story.",
                textAlign:
                    TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  ref
                      .read(
                        audioProvider
                            .notifier,
                      )
                      .reset();

                  ref
                      .read(
                        quizProvider
                            .notifier,
                      )
                      .reset();
                },
                child: const Text(
                  "Try Again",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,

        title: const Text(
          "AI Story Buddy",
          style: TextStyle(
            color: AppColors.primaryPurple,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.account_circle_outlined,
              color: AppColors.primaryPurple,
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
  children: [
    const SizedBox(height: 10),

    const BuddyWidget(),

    const SizedBox(height: 30),

    const StoryCard(),

    const SizedBox(height: 24),

    audioStatus == AudioStatus.speaking
        ? Column(
            children: [
              const StoryButton(
                text: "Speaking...",
                onPressed: null,
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final tts =
                        ref.read(ttsProvider);

                    await tts.stop();

                    ref
                        .read(audioProvider.notifier)
                        .reset();

                    ref
                        .read(quizProvider.notifier)
                        .reset();
                  },
                  icon: const Icon(Icons.stop),
                  label: const Text(
                    "Stop Story",
                  ),
                ),
              ),
            ],
          )
        : StoryButton(
            text: audioStatus ==
                    AudioStatus.loading
                ? "Preparing Story..."
                : "Read Me a Story",
            onPressed: () async {
              final audioNotifier =
                  ref.read(
                      audioProvider.notifier);

              final quizNotifier =
                  ref.read(
                      quizProvider.notifier);

              final tts =
                  ref.read(ttsProvider);

              try {
                audioNotifier.setLoading();

                await tts.initialize();

                audioNotifier.setSpeaking();

                // MUST COME BEFORE speak()

                tts.instance
                    .setCompletionHandler(() {
                  audioNotifier
                      .setCompleted();

                  quizNotifier.showQuiz();
                });

                await tts.speak(
                  AppStrings.storyText,
                );
              } catch (e) {
                audioNotifier.setError();
              }
            },
          ),
          const SizedBox(height: 24),

AnimatedSwitcher(
  duration:
      const Duration(
    milliseconds: 500,
  ),
  child: quizState.visible
      ? QuizCard(
          key: const ValueKey(
              "quiz"),
          quiz: quiz,
        )
      : const SizedBox.shrink(),
),
  ],
),
      ),
    );
  }
}