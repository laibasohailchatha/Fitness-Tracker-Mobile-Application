import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/workout_data.dart';
import '../models/workout_model.dart';
import '../widgets/workout_card.dart';
import 'exercise_detail_screen.dart';

class WorkoutCategoriesScreen extends StatefulWidget {
  const WorkoutCategoriesScreen({super.key});

  @override
  State<WorkoutCategoriesScreen> createState() =>
      _WorkoutCategoriesScreenState();
}

class _WorkoutCategoriesScreenState extends State<WorkoutCategoriesScreen> {
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Strength',
    'Cardio',
    'Yoga',
    'HIIT',
  ];

  List<WorkoutModel> get _filteredWorkouts {
    final all = WorkoutData.getAllWorkouts();
    if (_selectedCategory == 'All') return all;
    return all.where((w) => w.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Workouts',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Choose your workout plan',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Category filter tabs
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = category == _selectedCategory;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.white54,
                          fontSize: 14,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Workout list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _filteredWorkouts.length,
                itemBuilder: (context, index) {
                  final workout = _filteredWorkouts[index];
                  return WorkoutCard(
                    workout: workout,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ExerciseDetailScreen(workout: workout),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
