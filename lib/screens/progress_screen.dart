import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/theme_provider.dart';
import '../utils/theme_colors.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';
import '../utils/theme_colors.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          backgroundColor: TC.background(context),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    'Progress',
                    style: TextStyle(
                      color: TC.textPrimary(context),
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'This Week Summary',
                    style: TextStyle(
                      color: TC.textMuted(context),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryCard(
                          context: context,
                          icon: Icons.fitness_center,
                          iconColor: AppColors.primary,
                          label: 'Workouts',
                          value: '5',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildSummaryCard(
                          context: context,
                          icon: Icons.local_fire_department,
                          iconColor: AppColors.orange,
                          label: 'Calories',
                          value: '2,450\nkcal',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildSummaryCard(
                          context: context,
                          icon: Icons.access_time,
                          iconColor: AppColors.green,
                          label: 'Duration',
                          value: '3h 45m',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'Goals Progress',
                    style: TextStyle(
                      color: TC.textPrimary(context),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildProgressBar(
                    context: context,
                    icon: Icons.fitness_center,
                    iconColor: AppColors.primary,
                    label: 'Workout',
                    detail: '5 / 6 sessions',
                    percent: 0.83,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 16),
                  _buildProgressBar(
                    context: context,
                    icon: Icons.local_fire_department,
                    iconColor: AppColors.orange,
                    label: 'Calories Burn',
                    detail: '2,450 / ${AppConstants.dailyCalorieGoal * 5} kcal',
                    percent: 0.82,
                    color: AppColors.orange,
                  ),
                  const SizedBox(height: 16),
                  _buildProgressBar(
                    context: context,
                    icon: Icons.directions_walk,
                    iconColor: AppColors.green,
                    label: 'Steps',
                    detail: '6,432 / ${AppConstants.dailyStepGoal} steps',
                    percent: 0.64,
                    color: AppColors.green,
                  ),
                  const SizedBox(height: 28),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [TC.primary(context), TC.primaryDark(context)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Keep it up! 💪',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'You are 83% toward your weekly workout goal. Just one more session to go!',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            height: 1.5,
                          ),
                        ),
                      ],
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

  Widget _buildSummaryCard({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: TC.card(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 26),
          const SizedBox(height: 10),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: TC.textPrimary(context),
              fontSize: 16,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(color: TC.textMuted(context), fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String label,
    required String detail,
    required double percent,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: TC.card(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: TC.textPrimary(context),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                '${(percent * 100).toInt()}%',
                style: TextStyle(
                  color: color,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: percent,
              backgroundColor: TC.timerRingBg(context),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              detail,
              style: TextStyle(color: TC.textMuted(context), fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
