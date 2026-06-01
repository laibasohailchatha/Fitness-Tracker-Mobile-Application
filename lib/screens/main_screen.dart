import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_colors.dart';
import '../utils/theme_provider.dart';
import '../utils/theme_colors.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_screen.dart';
import 'workout_categories_screen.dart';
import 'progress_screen.dart';
import 'water_tracker_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final List<Widget> screens = [
          HomeTab(onSwitchTab: _onNavTap),
          const WorkoutCategoriesScreen(),
          const WaterTrackerScreen(),
          const ProgressScreen(),
        ];

        return Scaffold(
          backgroundColor: TC.background(context),
          body: IndexedStack(index: _currentIndex, children: screens),
          bottomNavigationBar: BottomNavBar(
            currentIndex: _currentIndex,
            onTap: _onNavTap,
          ),
        );
      },
    );
  }
}
