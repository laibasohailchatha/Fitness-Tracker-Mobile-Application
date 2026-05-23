import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class QuickActionsRow extends StatelessWidget {
  final VoidCallback onWorkoutTap;
  final VoidCallback onTimerTap;
  final VoidCallback onWaterTap;
  final VoidCallback onProgressTap;

  const QuickActionsRow({
    super.key,
    required this.onWorkoutTap,
    required this.onTimerTap,
    required this.onWaterTap,
    required this.onProgressTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildActionButton(
              icon: Icons.fitness_center,
              label: 'Workout',
              color: AppColors.primary,
              onTap: onWorkoutTap,
            ),
            _buildActionButton(
              icon: Icons.timer,
              label: 'Timer',
              color: AppColors.orange,
              onTap: onTimerTap,
            ),
            _buildActionButton(
              icon: Icons.water_drop,
              label: 'Water',
              color: AppColors.blue,
              onTap: onWaterTap,
            ),
            _buildActionButton(
              icon: Icons.bar_chart,
              label: 'Progress',
              color: AppColors.green,
              onTap: onProgressTap,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withOpacity(0.3), width: 1),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
