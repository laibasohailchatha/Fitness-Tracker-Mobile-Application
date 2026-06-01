import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../models/workout_model.dart';
import 'main_screen.dart';
import 'package:provider/provider.dart';
import '../utils/theme_provider.dart';
import '../utils/theme_colors.dart';

class WorkoutCompleteScreen extends StatelessWidget {
  final WorkoutModel workout;
  final int caloriesBurned;
  final int elapsedSeconds;

  const WorkoutCompleteScreen({
    super.key,
    required this.workout,
    required this.caloriesBurned,
    required this.elapsedSeconds,
  });

  String _formatTime(int seconds) {
    final mins = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          backgroundColor: TC.background(context),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: TC.primary(context).withOpacity(0.15),
                      shape: BoxShape.circle,
                      border: Border.all(color: TC.primary(context), width: 2),
                    ),
                    child: const Icon(
                      Icons.emoji_events,
                      color: AppColors.yellow,
                      size: 60,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'Workout Complete!',
                    style: TextStyle(
                      color: TC.textPrimary(context),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    workout.name,
                    style: TextStyle(
                      color: TC.textMuted(context),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStat(
                        context: context,
                        icon: Icons.local_fire_department,
                        color: AppColors.orange,
                        value: '$caloriesBurned kcal',
                        label: 'Calories',
                      ),
                      _buildStat(
                        context: context,
                        icon: Icons.access_time,
                        color: TC.primary(context),
                        value: _formatTime(elapsedSeconds),
                        label: 'Duration',
                      ),
                      _buildStat(
                        context: context,
                        icon: Icons.fitness_center,
                        color: AppColors.green,
                        value: '${workout.exercises.length}',
                        label: 'Exercises',
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TC.primary(context),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Back to Home',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStat({
    required BuildContext context,
    required IconData icon,
    required Color color,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 10),
        Text(
          value,
          style: TextStyle(
            color: TC.textPrimary(context),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: TC.textMuted(context), fontSize: 12),
        ),
      ],
    );
  }
}
