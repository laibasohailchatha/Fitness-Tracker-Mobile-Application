import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_colors.dart';
import 'theme_provider.dart';

class TC {
  static bool isDark(BuildContext context) {
    return Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
  }

  static Color background(BuildContext context) =>
      isDark(context) ? AppColors.background : AppColors.lightBackground;

  static Color card(BuildContext context) => isDark(context)
      ? AppColors.cardBackground
      : AppColors.lightCardBackground;

  static Color primary(BuildContext context) =>
      isDark(context) ? AppColors.primary : AppColors.lightPrimary;

  static Color primaryDark(BuildContext context) =>
      isDark(context) ? AppColors.primaryDark : AppColors.lightPrimaryDark;

  static Color textPrimary(BuildContext context) =>
      isDark(context) ? AppColors.textPrimary : AppColors.lightTextPrimary;

  static Color textSecondary(BuildContext context) =>
      isDark(context) ? AppColors.textSecondary : AppColors.lightTextSecondary;

  static Color textMuted(BuildContext context) =>
      isDark(context) ? AppColors.textMuted : AppColors.lightTextMuted;

  static Color timerRingBg(BuildContext context) =>
      isDark(context) ? AppColors.timerRingBg : AppColors.lightTimerRingBg;

  static Color surface(BuildContext context) =>
      isDark(context) ? AppColors.surfaceColor : AppColors.lightSurface;
}
