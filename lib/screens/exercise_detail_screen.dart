import 'package:flutter/material.dart';
import '../models/workout_model.dart';
import '../utils/app_colors.dart';
import 'workout_timer_screen.dart';

class ExerciseDetailScreen extends StatelessWidget {
  final WorkoutModel workout;

  const ExerciseDetailScreen({super.key, required this.workout});

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
    final exercise = workout.exercises.first;
    final color = _getCategoryColor(workout.category);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Top image area
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 280,
                decoration: BoxDecoration(color: color.withOpacity(0.15)),
                child: Icon(
                  Icons.fitness_center,
                  size: 120,
                  color: color.withOpacity(0.4),
                ),
              ),

              // Back button
              Positioned(
                top: 50,
                left: 16,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),

              // Favourite button
              Positioned(
                top: 50,
                right: 16,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and tags
                  Text(
                    exercise.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      _buildTag(workout.category, color),
                      const SizedBox(width: 8),
                      _buildTag(exercise.muscleGroup, Colors.white30),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Description
                  Text(
                    exercise.description,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Stats row
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.repeat,
                          label: 'Sets',
                          value: '${exercise.sets} Sets',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.fitness_center,
                          label: 'Reps',
                          value: '${exercise.reps} Reps',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.timer,
                          label: 'Rest',
                          value: '${exercise.restSeconds} sec',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // All exercises in this workout
                  const Text(
                    'Exercises in this workout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 12),

                  ...workout.exercises.map(
                    (ex) => _buildExerciseRow(ex, color),
                  ),

                  const SizedBox(height: 30),

                  // Start workout button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                WorkoutTimerScreen(workout: workout),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Start Workout',
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
        ],
      ),
    );
  }

  Widget _buildTag(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 22),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(color: Colors.white54, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseRow(ExerciseModel exercise, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.fitness_center, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${exercise.sets} sets x ${exercise.reps} reps',
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            '${exercise.restSeconds}s rest',
            style: const TextStyle(color: Colors.white38, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
