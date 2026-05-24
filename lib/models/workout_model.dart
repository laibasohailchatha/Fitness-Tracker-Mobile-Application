class WorkoutModel {
  final String id;
  final String name;
  final String category;
  final String difficulty;
  final int durationMinutes;
  final int exerciseCount;
  final String description;
  final List<ExerciseModel> exercises;

  WorkoutModel({
    required this.id,
    required this.name,
    required this.category,
    required this.difficulty,
    required this.durationMinutes,
    required this.exerciseCount,
    required this.description,
    required this.exercises,
  });
}

class ExerciseModel {
  final String name;
  final int sets;
  final int reps;
  final int restSeconds;
  final String description;
  final String muscleGroup;

  ExerciseModel({
    required this.name,
    required this.sets,
    required this.reps,
    required this.restSeconds,
    required this.description,
    required this.muscleGroup,
  });
}
