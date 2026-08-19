import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class OnboardingSliderItem extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final LinearGradient gradient;
  final String? letter;

  const OnboardingSliderItem({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.gradient,
    this.letter,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: gradient,
            ),
            alignment: Alignment.center,
            child: letter != null
                ? Text(
                    letter!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Icon(
                    icon,
                    size: 48,
                    color: Colors.white,
                  ),
          ),
          const SizedBox(height: 40),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textGray,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}
