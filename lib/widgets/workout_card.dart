import 'package:flutter/material.dart';
import '../models/workout_model.dart';
import '../utils/app_colors.dart';

class WorkoutCard extends StatelessWidget {
  final WorkoutModel workout;
  final VoidCallback onTap;

  const WorkoutCard({super.key, required this.workout, required this.onTap});

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Strength':
        return AppColors.primary;
      case 'Cardio':
        return AppColors.orange;
      case 'HIIT':
        return const Color(0xFFEF4444);
      case 'Yoga':
        return AppColors.green;
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getCategoryColor(workout.category);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        height: 110,
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            // Left image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: Image.asset(
                workout.imagePath,
                width: 110,
                height: 110,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 110,
                    height: 110,
                    color: color.withOpacity(0.15),
                    child: Icon(Icons.fitness_center, color: color, size: 40),
                  );
                },
              ),
            ),

            // Workout info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      workout.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.fitness_center,
                          color: Colors.white54,
                          size: 13,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${workout.exerciseCount} Exercises',
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.access_time,
                          color: Colors.white54,
                          size: 13,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${workout.durationMinutes} min',
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        workout.difficulty,
                        style: TextStyle(
                          color: color,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Arrow
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white30,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
