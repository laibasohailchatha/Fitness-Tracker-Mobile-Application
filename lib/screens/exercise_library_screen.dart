import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_colors.dart';
import '../utils/theme_provider.dart';
import '../utils/theme_colors.dart';
import 'exercise_library_detail_screen.dart';

class ExerciseLibraryScreen extends StatefulWidget {
  const ExerciseLibraryScreen({super.key});

  @override
  State<ExerciseLibraryScreen> createState() => _ExerciseLibraryScreenState();
}

class _ExerciseLibraryScreenState extends State<ExerciseLibraryScreen> {
  String _selectedCategory = 'All';
  String _searchQuery = '';

  final List<String> _categories = [
    'All',
    'Chest',
    'Back',
    'Legs',
    'Arms',
    'Core',
    'Shoulders',
  ];

  final List<Map<String, String>> _exercises = [
    {
      'name': 'Push Ups',
      'category': 'Chest',
      'level': 'Beginner',
      'description':
          'Push ups are a classic bodyweight exercise that targets the chest, shoulders, and triceps. Start in a plank position with hands shoulder-width apart. Lower your chest to the floor then push back up.',
      'sets': '3',
      'reps': '15',
      'rest': '60 sec',
      'tips': 'Keep your core tight and back straight throughout the movement.',
    },
    {
      'name': 'Dumbbell Rows',
      'category': 'Back',
      'level': 'Intermediate',
      'description':
          'Dumbbell rows target the latissimus dorsi and rhomboids. Bend over with a flat back, hold a dumbbell in one hand and row it toward your hip.',
      'sets': '3',
      'reps': '12',
      'rest': '60 sec',
      'tips':
          'Keep your elbow close to your body and squeeze your back at the top.',
    },
    {
      'name': 'Lunges',
      'category': 'Legs',
      'level': 'Beginner',
      'description':
          'Lunges are a great lower body exercise targeting the quads, hamstrings, and glutes. Step forward and lower your back knee toward the floor.',
      'sets': '3',
      'reps': '12',
      'rest': '60 sec',
      'tips': 'Keep your front knee behind your toes and torso upright.',
    },
    {
      'name': 'Plank',
      'category': 'Core',
      'level': 'Beginner',
      'description':
          'The plank is an isometric core exercise that builds stability and strength. Hold a push up position with forearms on the floor.',
      'sets': '3',
      'reps': '30 sec',
      'rest': '45 sec',
      'tips':
          'Do not let your hips sag or rise. Keep a straight line from head to heels.',
    },
    {
      'name': 'Bicep Curls',
      'category': 'Arms',
      'level': 'Beginner',
      'description':
          'Bicep curls isolate the bicep muscles. Stand with dumbbells at your sides and curl them up toward your shoulders.',
      'sets': '3',
      'reps': '12',
      'rest': '60 sec',
      'tips': 'Avoid swinging your body. Control the weight on the way down.',
    },
    {
      'name': 'Shoulder Press',
      'category': 'Shoulders',
      'level': 'Intermediate',
      'description':
          'The shoulder press targets the deltoids and triceps. Press dumbbells overhead from shoulder height until arms are fully extended.',
      'sets': '3',
      'reps': '10',
      'rest': '90 sec',
      'tips': 'Do not arch your lower back. Engage your core throughout.',
    },
    {
      'name': 'Squats',
      'category': 'Legs',
      'level': 'Beginner',
      'description':
          'Squats are the king of lower body exercises targeting quads, hamstrings, and glutes. Stand with feet shoulder-width apart and lower your hips.',
      'sets': '4',
      'reps': '20',
      'rest': '60 sec',
      'tips':
          'Keep your chest up, knees tracking over toes, and weight in your heels.',
    },
    {
      'name': 'Pull Ups',
      'category': 'Back',
      'level': 'Advanced',
      'description':
          'Pull ups are a challenging upper body exercise that targets the back and biceps. Hang from a bar and pull your chin above it.',
      'sets': '3',
      'reps': '8',
      'rest': '90 sec',
      'tips': 'Use a full range of motion. Start from a dead hang each rep.',
    },
    {
      'name': 'Tricep Dips',
      'category': 'Arms',
      'level': 'Intermediate',
      'description':
          'Tricep dips target the triceps using parallel bars or a bench. Lower your body by bending your elbows then press back up.',
      'sets': '3',
      'reps': '12',
      'rest': '60 sec',
      'tips': 'Keep your elbows pointing straight back, not flaring out.',
    },
    {
      'name': 'Deadlift',
      'category': 'Back',
      'level': 'Advanced',
      'description':
          'The deadlift is a compound movement targeting the entire posterior chain. Lift a barbell from the floor to hip height with a neutral spine.',
      'sets': '4',
      'reps': '6',
      'rest': '120 sec',
      'tips': 'Keep the bar close to your body and drive through your heels.',
    },
    {
      'name': 'Crunches',
      'category': 'Core',
      'level': 'Beginner',
      'description':
          'Crunches are a classic abdominal exercise. Lie on your back with knees bent and lift your shoulders off the floor.',
      'sets': '3',
      'reps': '20',
      'rest': '45 sec',
      'tips': 'Do not pull on your neck. Focus on contracting your abs.',
    },
    {
      'name': 'Bench Press',
      'category': 'Chest',
      'level': 'Intermediate',
      'description':
          'The bench press is the primary chest exercise. Lie on a bench and press a barbell or dumbbells from chest height to full extension.',
      'sets': '4',
      'reps': '10',
      'rest': '90 sec',
      'tips':
          'Keep your feet flat on the floor and maintain a slight arch in your lower back.',
    },
  ];

  List<Map<String, String>> get _filteredExercises {
    return _exercises.where((exercise) {
      final matchesCategory =
          _selectedCategory == 'All' ||
          exercise['category'] == _selectedCategory;
      final matchesSearch = exercise['name']!.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
      return matchesCategory && matchesSearch;
    }).toList();
  }

  Color _getLevelColor(String level) {
    switch (level) {
      case 'Beginner':
        return AppColors.green;
      case 'Intermediate':
        return AppColors.yellow;
      case 'Advanced':
        return AppColors.orange;
      default:
        return AppColors.green;
    }
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                            'Exercise Library',
                            style: TextStyle(
                              color: TC.textPrimary(context),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 24),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Search bar
                      Container(
                        decoration: BoxDecoration(
                          color: TC.card(context),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: TextField(
                          onChanged: (value) {
                            setState(() => _searchQuery = value);
                          },
                          style: TextStyle(color: TC.textPrimary(context)),
                          decoration: InputDecoration(
                            hintText: 'Search exercises...',
                            hintStyle: TextStyle(color: TC.textMuted(context)),
                            prefixIcon: Icon(
                              Icons.search,
                              color: TC.textMuted(context),
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Category tabs
                SizedBox(
                  height: 36,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final cat = _categories[index];
                      final isSelected = cat == _selectedCategory;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedCategory = cat),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? TC.primary(context)
                                : TC.card(context),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            cat,
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
                    },
                  ),
                ),

                const SizedBox(height: 12),

                // Exercise list
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _filteredExercises.length,
                    itemBuilder: (context, index) {
                      final exercise = _filteredExercises[index];
                      final levelColor = _getLevelColor(exercise['level']!);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExerciseLibraryDetailScreen(
                                exercise: exercise,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: TC.card(context),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: TC.primary(context).withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.fitness_center,
                                  color: TC.primary(context),
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      exercise['name']!,
                                      style: TextStyle(
                                        color: TC.textPrimary(context),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          exercise['category']!,
                                          style: TextStyle(
                                            color: TC.textMuted(context),
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          ' • ',
                                          style: TextStyle(
                                            color: TC.textMuted(context),
                                          ),
                                        ),
                                        Text(
                                          exercise['level']!,
                                          style: TextStyle(
                                            color: levelColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
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
                        ),
                      );
                    },
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
