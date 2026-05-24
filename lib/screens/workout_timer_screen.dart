import 'package:flutter/material.dart';
import '../models/workout_model.dart';
import '../utils/app_colors.dart';

class WorkoutTimerScreen extends StatelessWidget {
  final WorkoutModel workout;

  const WorkoutTimerScreen({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Text(
          'Timer Screen',
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
