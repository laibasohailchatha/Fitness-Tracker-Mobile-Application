import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';
import '../widgets/activity_progress_card.dart';
import '../widgets/quick_actions_row.dart';
import '../widgets/todays_workout_card.dart';
import 'workout_categories_screen.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final int _calories = 520;
  final int _workoutMinutes = 45;
  final int _steps = 6432;

  double get _activityPercentage {
    double calPercent = _calories / AppConstants.dailyCalorieGoal;
    double stepPercent = _steps / AppConstants.dailyStepGoal;
    double workoutPercent = _workoutMinutes / AppConstants.dailyWorkoutMinutes;
    double avg = (calPercent + stepPercent + workoutPercent) / 3;
    return avg.clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Top bar
              _buildTopBar(),

              const SizedBox(height: 24),

              // Activity progress
              ActivityProgressCard(
                percentage: _activityPercentage,
                calories: _calories,
                calorieGoal: AppConstants.dailyCalorieGoal,
                workoutMinutes: _workoutMinutes,
                workoutGoal: AppConstants.dailyWorkoutMinutes,
                steps: _steps,
                stepGoal: AppConstants.dailyStepGoal,
              ),

              const SizedBox(height: 28),

              // Quick actions
              QuickActionsRow(
                onWorkoutTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WorkoutCategoriesScreen(),
                    ),
                  );
                },
                onTimerTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WorkoutCategoriesScreen(),
                    ),
                  );
                },
                onWaterTap: () {
                  // Water tab is index 2 in bottom nav
                  // This is handled by MainScreen
                },
                onProgressTap: () {
                  // Progress tab is index 3 in bottom nav
                  // This is handled by MainScreen
                },
              ),

              const SizedBox(height: 28),

              // Today's workout
              TodaysWorkoutCard(
                workoutName: 'Full Body Burn',
                difficulty: 'Intermediate',
                durationMinutes: 35,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WorkoutCategoriesScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hi, Ayush! 👋',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Ready to crush your goals today?',
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 14,
              ),
            ),
          ],
        ),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.notifications_outlined,
            color: Colors.white70,
            size: 22,
          ),
        ),
      ],
    );
  }
}
