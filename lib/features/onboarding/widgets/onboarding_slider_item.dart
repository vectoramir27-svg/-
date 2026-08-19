import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class OnboardingSliderItem extends StatelessWidget {
  final IconData? icon;
  final String? letter;
  final LinearGradient gradient;
  final String title;
  final String desc;

  const OnboardingSliderItem({
    super.key,
    this.icon,
    this.letter,
    required this.gradient,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: gradient,
              boxShadow: [
                BoxShadow(
                  color: gradient.colors.last.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ],
            ),
            alignment: Alignment.center,
            child: letter != null
                ? Text(
                    letter!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 44,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Icon(icon, size: 48, color: Colors.white),
          ),
          const SizedBox(height: 36),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textGray,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}