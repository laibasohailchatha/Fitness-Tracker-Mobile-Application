import 'package:flutter/material.dart';
import '../models/workout_model.dart';
import '../utils/app_colors.dart';
import 'package:provider/provider.dart';
import '../utils/theme_provider.dart';
import '../utils/theme_colors.dart';

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
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final color = _getCategoryColor(workout.category);
        return GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            height: 110,
            decoration: BoxDecoration(
              color: TC.card(context),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
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
                        child: Icon(
                          Icons.fitness_center,
                          color: color,
                          size: 40,
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          workout.name,
                          style: TextStyle(
                            color: TC.textPrimary(context),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(
                              Icons.fitness_center,
                              color: TC.textMuted(context),
                              size: 13,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${workout.exerciseCount} Exercises',
                              style: TextStyle(
                                color: TC.textMuted(context),
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Icon(
                              Icons.access_time,
                              color: TC.textMuted(context),
                              size: 13,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${workout.durationMinutes} min',
                              style: TextStyle(
                                color: TC.textMuted(context),
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
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: TC.textMuted(context),
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
