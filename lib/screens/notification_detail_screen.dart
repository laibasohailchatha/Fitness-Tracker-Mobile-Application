import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_colors.dart';
import '../utils/theme_provider.dart';
import '../utils/theme_colors.dart';

class NotificationDetailScreen extends StatelessWidget {
  final Map<String, dynamic> notification;

  const NotificationDetailScreen({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          backgroundColor: TC.background(context),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top bar
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back,
                          color: TC.textPrimary(context),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Notification',
                        style: TextStyle(
                          color: TC.textPrimary(context),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Icon
                  Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: (notification['color'] as Color).withOpacity(
                          0.15,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        notification['icon'] as IconData,
                        color: notification['color'] as Color,
                        size: 40,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Title
                  Center(
                    child: Text(
                      notification['title'] as String,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: TC.textPrimary(context),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Time
                  Center(
                    child: Text(
                      notification['time'] as String,
                      style: TextStyle(
                        color: TC.textMuted(context),
                        fontSize: 13,
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Full message
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: TC.card(context),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      notification['fullMessage'] as String,
                      style: TextStyle(
                        color: TC.textSecondary(context),
                        fontSize: 15,
                        height: 1.7,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
