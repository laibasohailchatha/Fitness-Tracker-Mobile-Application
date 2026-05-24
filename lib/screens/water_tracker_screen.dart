import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';

class WaterTrackerScreen extends StatefulWidget {
  const WaterTrackerScreen({super.key});

  @override
  State<WaterTrackerScreen> createState() => _WaterTrackerScreenState();
}

class _WaterTrackerScreenState extends State<WaterTrackerScreen> {
  int _glassesConsumed = 0;
  final int _dailyGoal = AppConstants.dailyWaterGlasses;

  void _addWater() {
    if (_glassesConsumed < _dailyGoal) {
      setState(() => _glassesConsumed++);
    }
  }

  void _removeWater() {
    if (_glassesConsumed > 0) {
      setState(() => _glassesConsumed--);
    }
  }

  double get _totalLiters => _glassesConsumed * 0.25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Water Tracker',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(Icons.more_vert, color: Colors.white54),
                ],
              ),

              const SizedBox(height: 32),

              // Goal display
              Center(
                child: Column(
                  children: [
                    const Text(
                      "Today's Goal",
                      style: TextStyle(color: Colors.white54, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$_glassesConsumed / $_dailyGoal Glasses',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Water glasses grid
              Center(
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: List.generate(_dailyGoal, (index) {
                    final isFilled = index < _glassesConsumed;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isFilled) {
                            _glassesConsumed = index;
                          } else {
                            _glassesConsumed = index + 1;
                          }
                        });
                      },
                      child: Container(
                        width: 60,
                        height: 70,
                        decoration: BoxDecoration(
                          color: isFilled
                              ? AppColors.blue.withOpacity(0.3)
                              : AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isFilled ? AppColors.blue : Colors.white12,
                            width: 1.5,
                          ),
                        ),
                        child: Icon(
                          Icons.water_drop,
                          color: isFilled ? AppColors.blue : Colors.white24,
                          size: 28,
                        ),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 28),

              // Goal reached message
              if (_glassesConsumed >= _dailyGoal)
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.green.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.green.withOpacity(0.3),
                      ),
                    ),
                    child: const Text(
                      "Great! You've hit your daily goal! 🎉",
                      style: TextStyle(color: AppColors.green, fontSize: 14),
                    ),
                  ),
                ),

              const Spacer(),

              // Add water button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _addWater,
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    'Add Water',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Total intake card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Intake',
                      style: TextStyle(color: Colors.white54, fontSize: 14),
                    ),
                    Text(
                      '${_totalLiters.toStringAsFixed(1)} Liters',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
