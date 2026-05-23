import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/activity_progress_card.dart';
import '../widgets/quick_actions_row.dart';
import '../widgets/todays_workout_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;

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

  void _onNavTap(int index) {
    setState(() {
      _currentNavIndex = index;
    });
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
              _buildTopBar(),
              const SizedBox(height: 24),
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
              QuickActionsRow(
                onWorkoutTap: () => _onNavTap(1),
                onTimerTap: () => _onNavTap(2),
                onWaterTap: () {},
                onProgressTap: () => _onNavTap(3),
              ),
              const SizedBox(height: 28),
              TodaysWorkoutCard(
                workoutName: 'Full Body Burn',
                difficulty: 'Intermediate',
                durationMinutes: 35,
                onTap: () {},
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentNavIndex,
        onTap: _onNavTap,
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
