import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class MotivationalBanner extends StatelessWidget {
  const MotivationalBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final quotes = [
      'Push yourself, no one else will do it for you.',
      'Your body can do it. Convince your mind.',
      'Sweat now, shine later.',
      'One workout at a time.',
      'Make yourself proud.',
    ];

    final quote = quotes[DateTime.now().weekday % quotes.length];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.25),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.format_quote, color: AppColors.primary, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              quote,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
