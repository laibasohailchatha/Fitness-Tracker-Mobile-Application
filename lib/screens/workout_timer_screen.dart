import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../models/workout_model.dart';
import '../utils/app_colors.dart';

class WorkoutTimerScreen extends StatefulWidget {
  final WorkoutModel workout;

  const WorkoutTimerScreen({super.key, required this.workout});

  @override
  State<WorkoutTimerScreen> createState() => _WorkoutTimerScreenState();
}

class _WorkoutTimerScreenState extends State<WorkoutTimerScreen> {
  late int _totalSeconds;
  late int _remainingSeconds;
  bool _isRunning = false;
  Timer? _timer;
  Timer? _elapsedTimer;
  int _currentExerciseIndex = 0;
  int _caloriesBurned = 0;
  int _elapsedSeconds = 0;

  ExerciseModel get _currentExercise {
    return widget.workout.exercises[_currentExerciseIndex];
  }

  @override
  void initState() {
    super.initState();
    _totalSeconds = _currentExercise.restSeconds;
    _remainingSeconds = _totalSeconds;
  }

  void _startTimer() {
    setState(() {
      _isRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
          _caloriesBurned++;
        });
      } else {
        t.cancel();
        setState(() {
          _isRunning = false;
        });
      }
    });

    _elapsedTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        _elapsedSeconds++;
      });
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    _elapsedTimer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _nextExercise() {
    _timer?.cancel();
    _elapsedTimer?.cancel();
    if (_currentExerciseIndex < widget.workout.exercises.length - 1) {
      setState(() {
        _currentExerciseIndex++;
        _totalSeconds = _currentExercise.restSeconds;
        _remainingSeconds = _totalSeconds;
        _isRunning = false;
        _elapsedSeconds = 0;
      });
    }
  }

  void _previousExercise() {
    _timer?.cancel();
    _elapsedTimer?.cancel();
    if (_currentExerciseIndex > 0) {
      setState(() {
        _currentExerciseIndex--;
        _totalSeconds = _currentExercise.restSeconds;
        _remainingSeconds = _totalSeconds;
        _isRunning = false;
        _elapsedSeconds = 0;
      });
    }
  }

  String _formatTime(int seconds) {
    final mins = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }

  @override
  void dispose() {
    _timer?.cancel();
    _elapsedTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double progress = _remainingSeconds / _totalSeconds;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Workout Timer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.music_note_outlined,
                    color: Colors.white54,
                    size: 24,
                  ),
                ],
              ),
            ),

            Text(
              widget.workout.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              'Round ${_currentExerciseIndex + 1} / ${widget.workout.exercises.length}',
              style: const TextStyle(color: Colors.white54, fontSize: 14),
            ),

            const SizedBox(height: 40),

            CircularPercentIndicator(
              radius: 130,
              lineWidth: 12,
              percent: progress.clamp(0.0, 1.0),
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Exercise',
                    style: TextStyle(color: Colors.white54, fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(_remainingSeconds),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _currentExercise.name,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
              progressColor: AppColors.primary,
              backgroundColor: AppColors.timerRingBg,
              circularStrokeCap: CircularStrokeCap.round,
            ),

            const SizedBox(height: 48),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _previousExercise,
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.skip_previous,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),

                const SizedBox(width: 20),

                GestureDetector(
                  onTap: _isRunning ? _pauseTimer : _startTimer,
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      _isRunning ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                ),

                const SizedBox(width: 20),

                GestureDetector(
                  onTap: _nextExercise,
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.skip_next,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem(
                    label: 'Elapsed',
                    value: _formatTime(_elapsedSeconds),
                  ),
                  _buildStatItem(
                    label: 'Calories',
                    value: '$_caloriesBurned kcal',
                  ),
                  _buildStatItem(label: 'Heart Rate', value: '128 bpm'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({required String label, required String value}) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
