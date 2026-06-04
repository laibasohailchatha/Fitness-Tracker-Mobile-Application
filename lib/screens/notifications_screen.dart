import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_colors.dart';
import '../utils/theme_provider.dart';
import '../utils/theme_colors.dart';
import 'notification_detail_screen.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'icon': Icons.water_drop,
      'color': AppColors.blue,
      'title': 'Time to Drink Water!',
      'message': "Don't forget to stay hydrated.",
      'fullMessage':
          "Staying hydrated is essential for your workout performance and overall health. You should aim to drink at least 8 glasses of water per day. Make sure to drink water before, during, and after your workouts to maintain peak performance.",
      'time': '5m ago',
      'isRead': false,
    },
    {
      'icon': Icons.fitness_center,
      'color': AppColors.orange,
      'title': 'Workout Reminder',
      'message': 'Your workout is scheduled for 6:00 PM.',
      'fullMessage':
          "Your scheduled workout is coming up at 6:00 PM today. You have a Full Body Burn session planned. Make sure to warm up properly before starting and have your water bottle ready. Consistency is the key to achieving your fitness goals!",
      'time': '1h ago',
      'isRead': false,
    },
    {
      'icon': Icons.check_circle,
      'color': AppColors.green,
      'title': 'Daily Goal Achieved! 🎉',
      'message': "You've completed your daily goals. Great job!",
      'fullMessage':
          "Congratulations! You have successfully completed all your daily fitness goals today. You burned 600 calories, walked 10,000 steps, and completed your scheduled workout. Keep up this amazing consistency and you will achieve your fitness targets in no time!",
      'time': '2h ago',
      'isRead': true,
    },
    {
      'icon': Icons.star,
      'color': AppColors.yellow,
      'title': 'New Badge Earned 🔥',
      'message': "You earned the '7-Day Streak' badge.",
      'fullMessage':
          "Amazing achievement! You have worked out for 7 consecutive days and earned the 7-Day Streak badge. This shows incredible dedication and commitment to your fitness journey. Keep the streak going and unlock even more badges. Your next milestone is the 14-Day Streak badge!",
      'time': '1d ago',
      'isRead': true,
    },
    {
      'icon': Icons.flag,
      'color': AppColors.primary,
      'title': 'Weekly Challenge',
      'message': "Don't forget your weekly challenge.",
      'fullMessage':
          "Your weekly challenge is to complete 5 workouts this week. You have completed 3 so far with 2 more days remaining. Push yourself to finish strong and complete the remaining 2 workouts. Completing this challenge will earn you bonus points and a special badge!",
      'time': '1d ago',
      'isRead': true,
    },
  ];

  void _markAllRead() {
    setState(() {
      for (var n in _notifications) {
        n['isRead'] = true;
      }
    });
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
                // Top bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back,
                          color: TC.textPrimary(context),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Notifications',
                          style: TextStyle(
                            color: TC.textPrimary(context),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _markAllRead,
                        child: Text(
                          'Mark all as read',
                          style: TextStyle(
                            color: TC.primary(context),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Notification list
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _notifications.length,
                    itemBuilder: (context, index) {
                      final notification = _notifications[index];
                      final isRead = notification['isRead'] as bool;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _notifications[index]['isRead'] = true;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationDetailScreen(
                                notification: notification,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: TC.card(context),
                            borderRadius: BorderRadius.circular(16),
                            border: isRead
                                ? null
                                : Border.all(
                                    color: TC.primary(context).withOpacity(0.3),
                                    width: 1,
                                  ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: (notification['color'] as Color)
                                      .withOpacity(0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  notification['icon'] as IconData,
                                  color: notification['color'] as Color,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      notification['title'] as String,
                                      style: TextStyle(
                                        color: TC.textPrimary(context),
                                        fontSize: 14,
                                        fontWeight: isRead
                                            ? FontWeight.normal
                                            : FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      notification['message'] as String,
                                      style: TextStyle(
                                        color: TC.textMuted(context),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    notification['time'] as String,
                                    style: TextStyle(
                                      color: TC.textMuted(context),
                                      fontSize: 11,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  if (!isRead)
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: TC.primary(context),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                ],
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
