import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../utils/app_colors.dart';
import '../utils/theme_colors.dart';

class ActivityProgressCard extends StatelessWidget {
  final double percentage;
  final int calories;
  final int calorieGoal;
  final int workoutMinutes;
  final int workoutGoal;
  final int steps;
  final int stepGoal;

  const ActivityProgressCard({
    super.key,
    required this.percentage,
    required this.calories,
    required this.calorieGoal,
    required this.workoutMinutes,
    required this.workoutGoal,
    required this.steps,
    required this.stepGoal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: TC.card(context),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Activity",
            style: TextStyle(
              color: TC.textPrimary(context),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              CircularPercentIndicator(
                radius: 65,
                lineWidth: 10,
                percent: percentage,
                center: Text(
                  '${(percentage * 100).toInt()}%',
                  style: TextStyle(
                    color: TC.textPrimary(context),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                progressColor: AppColors.primary,
                backgroundColor: TC.timerRingBg(context),
                circularStrokeCap: CircularStrokeCap.round,
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  children: [
                    _buildStatRow(
                      context: context,
                      icon: Icons.local_fire_department,
                      iconColor: AppColors.orange,
                      label: 'Calories',
                      value: '$calories / $calorieGoal cal',
                    ),
                    const SizedBox(height: 16),
                    _buildStatRow(
                      context: context,
                      icon: Icons.fitness_center,
                      iconColor: AppColors.primary,
                      label: 'Workout',
                      value: '$workoutMinutes / $workoutGoal min',
                    ),
                    const SizedBox(height: 16),
                    _buildStatRow(
                      context: context,
                      icon: Icons.directions_walk,
                      iconColor: AppColors.green,
                      label: 'Steps',
                      value:
                          '${_formatNumber(steps)} / ${_formatNumber(stepGoal)}',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 20),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(color: TC.textMuted(context), fontSize: 11),
            ),
            Text(
              value,
              style: TextStyle(
                color: TC.textPrimary(context),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    }
    return number.toString();
  }
}
