import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_colors.dart';
import '../utils/theme_provider.dart';
import '../utils/theme_colors.dart';

class BmiCalculatorScreen extends StatefulWidget {
  const BmiCalculatorScreen({super.key});

  @override
  State<BmiCalculatorScreen> createState() => _BmiCalculatorScreenState();
}

class _BmiCalculatorScreenState extends State<BmiCalculatorScreen> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double? _bmi;
  String _bmiCategory = '';
  Color _bmiColor = AppColors.green;

  void _calculateBmi() {
    final double? height = double.tryParse(_heightController.text);
    final double? weight = double.tryParse(_weightController.text);

    if (height == null || weight == null || height <= 0 || weight <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid height and weight')),
      );
      return;
    }

    final double heightInMeters = height / 100;
    final double bmi = weight / (heightInMeters * heightInMeters);

    setState(() {
      _bmi = bmi;
      if (bmi < 18.5) {
        _bmiCategory = 'Underweight';
        _bmiColor = AppColors.blue;
      } else if (bmi < 25.0) {
        _bmiCategory = 'Normal';
        _bmiColor = AppColors.green;
      } else if (bmi < 30.0) {
        _bmiCategory = 'Overweight';
        _bmiColor = AppColors.yellow;
      } else {
        _bmiCategory = 'Obese';
        _bmiColor = AppColors.orange;
      }
    });
  }

  String _getBmiMessage() {
    switch (_bmiCategory) {
      case 'Underweight':
        return 'Your BMI is below normal. Consider increasing your caloric intake and strength training.';
      case 'Normal':
        return 'Great! Your BMI is in the normal range. Keep up the good work! 💪';
      case 'Overweight':
        return 'Your BMI is slightly above normal. Regular exercise and a balanced diet can help.';
      case 'Obese':
        return 'Your BMI indicates obesity. Please consult a healthcare professional for guidance.';
      default:
        return '';
    }
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          backgroundColor: TC.background(context),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top bar
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
                        'BMI Calculator',
                        style: TextStyle(
                          color: TC.textPrimary(context),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(Icons.info_outline, color: Colors.transparent),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // Height input
                  _buildInputField(
                    context: context,
                    controller: _heightController,
                    label: 'Height (cm)',
                    hint: 'e.g. 165',
                    icon: Icons.height,
                  ),

                  const SizedBox(height: 16),

                  // Weight input
                  _buildInputField(
                    context: context,
                    controller: _weightController,
                    label: 'Weight (kg)',
                    hint: 'e.g. 60',
                    icon: Icons.monitor_weight_outlined,
                  ),

                  const SizedBox(height: 24),

                  // Calculate button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _calculateBmi,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: TC.primary(context),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Calculate BMI',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // BMI Result
                  if (_bmi != null) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: TC.card(context),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Your BMI',
                            style: TextStyle(
                              color: TC.textMuted(context),
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _bmi!.toStringAsFixed(1),
                            style: TextStyle(
                              color: _bmiColor,
                              fontSize: 64,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _bmiCategory,
                            style: TextStyle(
                              color: _bmiColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // BMI range bar
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 10,
                                    color: AppColors.blue,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 10,
                                    color: AppColors.green,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 10,
                                    color: AppColors.yellow,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 10,
                                    color: AppColors.orange,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 8),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Underweight\n< 18.5',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.blue,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                'Normal\n18.5 - 24.9',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.green,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                'Overweight\n25.0 - 29.9',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.yellow,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                'Obese\n> 30',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.orange,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: _bmiColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _bmiColor.withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              _getBmiMessage(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _bmiColor,
                                fontSize: 13,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: TC.card(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: TextStyle(color: TC.textPrimary(context)),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: TC.textMuted(context)),
          hintText: hint,
          hintStyle: TextStyle(color: TC.textMuted(context)),
          prefixIcon: Icon(icon, color: TC.primary(context)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
