import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_colors.dart';
import 'roadmap_tab_screen.dart';
import 'analytics_screen.dart';
import 'profile_screen.dart';
import 'ai_recommendation_screen.dart';
import 'course_completion_screen.dart'; // Just using this as a demo for "games" page

class MainNavigationScreen extends StatefulWidget {
  final String? initialLanguage;

  const MainNavigationScreen({super.key, this.initialLanguage});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  Widget? _roadmapScreen;

  Widget _buildCurrentScreen() {
    switch (_currentIndex) {
      case 0:
        return const AiRecommendationScreen();
      case 1:
        // lazily create and cache RoadmapTabScreen so initState runs only once
        _roadmapScreen ??= RoadmapTabScreen(language: widget.initialLanguage ?? 'Python');
        return _roadmapScreen!;
      case 2:
        return const CourseCompletionScreen();
      case 3:
        return const AnalyticsScreen();
      case 4:
        return const ProfileScreen();
      default:
        return const AiRecommendationScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _buildCurrentScreen(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.5),
          border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.1))),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryPurple.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            )
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedItemColor: AppColors.primaryPurple,
          unselectedItemColor: AppColors.textSecondary,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(icon: Icon(LucideIcons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(LucideIcons.map), label: 'Roadmap'),
            BottomNavigationBarItem(icon: Icon(LucideIcons.gamepad2), label: 'Games'),
            BottomNavigationBarItem(icon: Icon(LucideIcons.barChart2), label: 'Analytics'),
            BottomNavigationBarItem(icon: Icon(LucideIcons.user), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
