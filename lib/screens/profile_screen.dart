import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_colors.dart';
import '../utils/theme_provider.dart';
import '../utils/theme_colors.dart';
import 'bmi_calculator_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          backgroundColor: TC.background(context),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Top bar
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.arrow_back,
                            color: TC.textPrimary(context),
                          ),
                        ),
                        Text(
                          'My Profile',
                          style: TextStyle(
                            color: TC.textPrimary(context),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.settings_outlined,
                          color: TC.textPrimary(context),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Avatar
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: TC.primary(context).withOpacity(0.2),
                          border: Border.all(
                            color: TC.primary(context),
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: TC.primary(context),
                        ),
                      ),
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: TC.primary(context),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Name
                  Text(
                    'Laiba Sohail',
                    style: TextStyle(
                      color: TC.textPrimary(context),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'Fitness Enthusiast',
                    style: TextStyle(
                      color: TC.textMuted(context),
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Level badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.yellow.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star, color: AppColors.yellow, size: 16),
                        SizedBox(width: 4),
                        Text(
                          'Level 5 Athlete',
                          style: TextStyle(
                            color: AppColors.yellow,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Stats row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildStatBox(
                            context: context,
                            icon: Icons.fitness_center,
                            iconColor: TC.primary(context),
                            value: '25',
                            label: 'Workouts',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatBox(
                            context: context,
                            icon: Icons.local_fire_department,
                            iconColor: AppColors.orange,
                            value: '12,450',
                            label: 'Calories\nkcal',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatBox(
                            context: context,
                            icon: Icons.bolt,
                            iconColor: AppColors.green,
                            value: '15',
                            label: 'Streak\nDays',
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Personal info section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Personal Information',
                          style: TextStyle(
                            color: TC.textPrimary(context),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            color: TC.card(context),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              _buildInfoRow(
                                context: context,
                                icon: Icons.cake_outlined,
                                label: 'Age',
                                value: '22 Years',
                              ),
                              _buildDivider(context),
                              _buildInfoRow(
                                context: context,
                                icon: Icons.height,
                                label: 'Height',
                                value: "5'1\"",
                              ),
                              _buildDivider(context),
                              _buildInfoRow(
                                context: context,
                                icon: Icons.monitor_weight_outlined,
                                label: 'Weight',
                                value: '48 KG',
                              ),
                              _buildDivider(context),
                              _buildInfoRow(
                                context: context,
                                icon: Icons.flag_outlined,
                                label: 'Goal',
                                value: 'Stay Fit',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BmiCalculatorScreen(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.calculate_outlined,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'BMI Calculator',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TC.primary(context),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatBox({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: TC.card(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: TC.textPrimary(context),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(color: TC.textMuted(context), fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: TC.primary(context), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: TC.textSecondary(context), fontSize: 14),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: TC.textPrimary(context),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Divider(
      height: 1,
      color: TC.textMuted(context).withOpacity(0.15),
      indent: 16,
      endIndent: 16,
    );
  }
}
