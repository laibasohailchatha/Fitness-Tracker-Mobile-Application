import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_colors.dart';
import '../utils/theme_provider.dart';
import '../utils/theme_colors.dart';

class WorkoutHistoryScreen extends StatefulWidget {
  const WorkoutHistoryScreen({super.key});

  @override
  State<WorkoutHistoryScreen> createState() => _WorkoutHistoryScreenState();
}

class _WorkoutHistoryScreenState extends State<WorkoutHistoryScreen> {
  String _selectedFilter = 'All';

  final List<String> _filters = ['All', 'This Week', 'This Month'];

  final List<Map<String, dynamic>> _history = [
    {
      'name': 'Full Body Workout',
      'duration': '45 min',
      'calories': 320,
      'date': 'Today',
      'icon': Icons.fitness_center,
      'color': AppColors.primary,
    },
    {
      'name': 'Upper Body Strength',
      'duration': '38 min',
      'calories': 280,
      'date': 'Yesterday',
      'icon': Icons.fitness_center,
      'color': AppColors.orange,
    },
    {
      'name': 'Cardio HIIT',
      'duration': '30 min',
      'calories': 250,
      'date': 'May 10, 2024',
      'icon': Icons.directions_run,
      'color': const Color(0xFFEF4444),
    },
    {
      'name': 'Lower Body Focus',
      'duration': '40 min',
      'calories': 300,
      'date': 'May 9, 2024',
      'icon': Icons.fitness_center,
      'color': AppColors.green,
    },
    {
      'name': 'Morning Yoga',
      'duration': '25 min',
      'calories': 120,
      'date': 'May 8, 2024',
      'icon': Icons.self_improvement,
      'color': AppColors.blue,
    },
    {
      'name': 'Full Body Burn',
      'duration': '35 min',
      'calories': 290,
      'date': 'May 7, 2024',
      'icon': Icons.fitness_center,
      'color': AppColors.primary,
    },
    {
      'name': 'Cardio Rush',
      'duration': '28 min',
      'calories': 210,
      'date': 'May 6, 2024',
      'icon': Icons.directions_run,
      'color': AppColors.orange,
    },
  ];

  List<Map<String, dynamic>> get _filteredHistory {
    if (_selectedFilter == 'All') return _history;
    if (_selectedFilter == 'This Week') return _history.take(4).toList();
    return _history.take(6).toList();
  }

  Map<String, List<Map<String, dynamic>>> get _groupedHistory {
    final Map<String, List<Map<String, dynamic>>> grouped = {};
    for (final item in _filteredHistory) {
      final date = item['date'] as String;
      if (!grouped.containsKey(date)) {
        grouped[date] = [];
      }
      grouped[date]!.add(item);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          backgroundColor: TC.background(context),
          body: SafeArea(
            child: Column(
              children: [
                // Top bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back,
                          color: TC.textPrimary(context),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Workout History',
                          style: TextStyle(
                            color: TC.textPrimary(context),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.calendar_month_outlined,
                        color: TC.textPrimary(context),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Filter tabs
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _filters.map((filter) {
                    final isSelected = filter == _selectedFilter;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedFilter = filter),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? TC.primary(context)
                              : TC.card(context),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          filter,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : TC.textMuted(context),
                            fontSize: 13,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 16),

                // History list grouped by date
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: _groupedHistory.entries.map((entry) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              entry.key,
                              style: TextStyle(
                                color: TC.textPrimary(context),
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          ...entry.value.map((workout) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: TC.card(context),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 46,
                                    height: 46,
                                    decoration: BoxDecoration(
                                      color: (workout['color'] as Color)
                                          .withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      workout['icon'] as IconData,
                                      color: workout['color'] as Color,
                                      size: 22,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          workout['name'] as String,
                                          style: TextStyle(
                                            color: TC.textPrimary(context),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${workout['duration']} • ${workout['calories']} kcal',
                                          style: TextStyle(
                                            color: TC.textMuted(context),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: TC.textMuted(context),
                                    size: 16,
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      );
                    }).toList(),
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
