import '../models/workout_model.dart';

class WorkoutData {
  static List<WorkoutModel> getAllWorkouts() {
    return [
      WorkoutModel(
        id: '1',
        name: 'Full Body Burn',
        category: 'Strength',
        difficulty: 'Intermediate',
        durationMinutes: 35,
        exerciseCount: 6,
        description:
            'A complete full body workout targeting all major muscle groups. Perfect for building strength and endurance.',
        exercises: [
          ExerciseModel(
            name: 'Push Ups',
            sets: 3,
            reps: 15,
            restSeconds: 60,
            description:
                'Classic push up targeting chest, shoulders and triceps.',
            muscleGroup: 'Chest',
          ),
          ExerciseModel(
            name: 'Squats',
            sets: 3,
            reps: 20,
            restSeconds: 60,
            description: 'Bodyweight squats for lower body strength.',
            muscleGroup: 'Legs',
          ),
          ExerciseModel(
            name: 'Plank',
            sets: 3,
            reps: 30,
            restSeconds: 45,
            description: 'Core strengthening isometric hold.',
            muscleGroup: 'Core',
          ),
        ],
      ),
      WorkoutModel(
        id: '2',
        name: 'Upper Body Power',
        category: 'Strength',
        difficulty: 'Advanced',
        durationMinutes: 40,
        exerciseCount: 8,
        description:
            'Intense upper body workout focusing on chest, back, shoulders and arms.',
        exercises: [
          ExerciseModel(
            name: 'Barbell Squat',
            sets: 3,
            reps: 12,
            restSeconds: 60,
            description:
                'The barbell squat is a fundamental exercise that builds lower body strength and power.',
            muscleGroup: 'Legs',
          ),
          ExerciseModel(
            name: 'Pull Ups',
            sets: 3,
            reps: 10,
            restSeconds: 90,
            description: 'Upper body pulling movement for back and biceps.',
            muscleGroup: 'Back',
          ),
        ],
      ),
      WorkoutModel(
        id: '3',
        name: 'Lower Body Blast',
        category: 'Strength',
        difficulty: 'Intermediate',
        durationMinutes: 30,
        exerciseCount: 5,
        description: 'Targeted lower body workout for strong legs and glutes.',
        exercises: [
          ExerciseModel(
            name: 'Lunges',
            sets: 3,
            reps: 12,
            restSeconds: 60,
            description: 'Forward lunges for quad and glute development.',
            muscleGroup: 'Legs',
          ),
          ExerciseModel(
            name: 'Deadlift',
            sets: 3,
            reps: 10,
            restSeconds: 90,
            description: 'Fundamental posterior chain exercise.',
            muscleGroup: 'Back',
          ),
        ],
      ),
      WorkoutModel(
        id: '4',
        name: 'Cardio Rush',
        category: 'Cardio',
        difficulty: 'Beginner',
        durationMinutes: 25,
        exerciseCount: 6,
        description:
            'High energy cardio session to boost heart rate and burn calories fast.',
        exercises: [
          ExerciseModel(
            name: 'Jumping Jacks',
            sets: 3,
            reps: 30,
            restSeconds: 30,
            description: 'Full body cardio warm up exercise.',
            muscleGroup: 'Full Body',
          ),
          ExerciseModel(
            name: 'High Knees',
            sets: 3,
            reps: 20,
            restSeconds: 30,
            description: 'Running in place with high knee drive.',
            muscleGroup: 'Core',
          ),
        ],
      ),
      WorkoutModel(
        id: '5',
        name: 'HIIT Extreme',
        category: 'HIIT',
        difficulty: 'Advanced',
        durationMinutes: 20,
        exerciseCount: 8,
        description:
            'High intensity interval training for maximum calorie burn in minimum time.',
        exercises: [
          ExerciseModel(
            name: 'Burpees',
            sets: 4,
            reps: 10,
            restSeconds: 20,
            description: 'Full body explosive movement.',
            muscleGroup: 'Full Body',
          ),
          ExerciseModel(
            name: 'Jump Squats',
            sets: 4,
            reps: 15,
            restSeconds: 20,
            description: 'Explosive lower body plyometric exercise.',
            muscleGroup: 'Legs',
          ),
        ],
      ),
      WorkoutModel(
        id: '6',
        name: 'Morning Yoga',
        category: 'Yoga',
        difficulty: 'Beginner',
        durationMinutes: 30,
        exerciseCount: 10,
        description:
            'Gentle morning yoga flow to wake up the body and improve flexibility.',
        exercises: [
          ExerciseModel(
            name: 'Sun Salutation',
            sets: 3,
            reps: 5,
            restSeconds: 30,
            description: 'Classic yoga flow sequence.',
            muscleGroup: 'Full Body',
          ),
          ExerciseModel(
            name: 'Warrior Pose',
            sets: 2,
            reps: 8,
            restSeconds: 20,
            description: 'Standing balance and strength pose.',
            muscleGroup: 'Legs',
          ),
        ],
      ),
    ];
  }
}
