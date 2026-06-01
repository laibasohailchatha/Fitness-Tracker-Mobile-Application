import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '../utils/theme_provider.dart';
import '../utils/theme_colors.dart';
import '../models/workout_model.dart';
import '../utils/app_colors.dart';
import 'workout_complete_screen.dart';
import '../utils/theme_colors.dart';

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
  Timer? _heartRateTimer;
  int _currentExerciseIndex = 0;
  int _caloriesBurned = 0;
  int _elapsedSeconds = 0;
  int _heartRate = 80;
  final Random _random = Random();

  ExerciseModel get _currentExercise {
    return widget.workout.exercises[_currentExerciseIndex];
  }

  @override
  void initState() {
    super.initState();
    _totalSeconds = _currentExercise.restSeconds;
    _remainingSeconds = _totalSeconds;
    _heartRate = 75 + _random.nextInt(21);
  }

  void _startHeartRateTimer() {
    _heartRateTimer?.cancel();
    _heartRateTimer = Timer.periodic(const Duration(seconds: 7), (t) {
      setState(() {
        _heartRate = 75 + _random.nextInt(21);
      });
    });
  }

  void _startTimer() {
    setState(() {
      _isRunning = true;
    });

    _startHeartRateTimer();

    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
          if (_remainingSeconds % 5 == 0) {
            _caloriesBurned++;
          }
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
    _heartRateTimer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _nextExercise() {
    _timer?.cancel();
    _elapsedTimer?.cancel();
    _heartRateTimer?.cancel();
    if (_currentExerciseIndex < widget.workout.exercises.length - 1) {
      setState(() {
        _currentExerciseIndex++;
        _totalSeconds = _currentExercise.restSeconds;
        _remainingSeconds = _totalSeconds;
        _isRunning = false;
        _elapsedSeconds = 0;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WorkoutCompleteScreen(
            workout: widget.workout,
            caloriesBurned: _caloriesBurned,
            elapsedSeconds: _elapsedSeconds,
          ),
        ),
      );
    }
  }

  void _previousExercise() {
    _timer?.cancel();
    _elapsedTimer?.cancel();
    _heartRateTimer?.cancel();
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
    _heartRateTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double progress = _remainingSeconds / _totalSeconds;

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          backgroundColor: TC.background(context),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back,
                          color: TC.textPrimary(context),
                          size: 24,
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Workout Timer',
                            style: TextStyle(
                              color: TC.textPrimary(context),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.music_note_outlined,
                        color: TC.textMuted(context),
                        size: 24,
                      ),
                    ],
                  ),
                ),
                Text(
                  widget.workout.name,
                  style: TextStyle(
                    color: TC.textPrimary(context),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Round ${_currentExerciseIndex + 1} / ${widget.workout.exercises.length}',
                  style: TextStyle(color: TC.textMuted(context), fontSize: 14),
                ),
                const SizedBox(height: 40),
                CircularPercentIndicator(
                  radius: 130,
                  lineWidth: 12,
                  percent: progress.clamp(0.0, 1.0),
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Exercise',
                        style: TextStyle(
                          color: TC.textMuted(context),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatTime(_remainingSeconds),
                        style: TextStyle(
                          color: TC.textPrimary(context),
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _currentExercise.name,
                        style: TextStyle(
                          color: TC.textSecondary(context),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  progressColor: TC.primary(context),
                  backgroundColor: TC.timerRingBg(context),
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
                          color: TC.card(context),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          Icons.skip_previous,
                          color: TC.textPrimary(context),
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
                          color: TC.primary(context),
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
                          color: TC.card(context),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          Icons.skip_next,
                          color: TC.textPrimary(context),
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
                        context: context,
                        label: 'Elapsed',
                        value: _formatTime(_elapsedSeconds),
                      ),
                      _buildStatItem(
                        context: context,
                        label: 'Calories',
                        value: '$_caloriesBurned kcal',
                      ),
                      _buildStatItem(
                        context: context,
                        label: 'Heart Rate',
                        value: '$_heartRate bpm',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatItem({
    required BuildContext context,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(color: TC.textMuted(context), fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: TC.textPrimary(context),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
