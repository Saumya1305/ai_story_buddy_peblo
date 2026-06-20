import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

class StoryCard extends StatelessWidget {
  const StoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColors.cardBorder,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "STORY",
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              const Icon(
                Icons.menu_book_outlined,
                color: AppColors.primaryPurple,
              ),
            ],
          ),

          const SizedBox(height: 16),

          const Text(
            AppStrings.storyText,
            style: TextStyle(
              fontSize: 22,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}