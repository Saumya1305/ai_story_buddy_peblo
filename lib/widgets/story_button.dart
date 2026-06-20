import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class StoryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const StoryButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 65,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(
          Icons.volume_up_rounded,
          color: Colors.white,
        ),
        label: Text(
          text,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
      ),
    );
  }
}