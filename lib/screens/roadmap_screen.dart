import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_container.dart';
import 'topic_detail_screen.dart';

class RoadmapScreen extends StatelessWidget {
  const RoadmapScreen({super.key});

  void _navigateToTopic(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const TopicDetailScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Python Roadmap', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.fileText, color: AppColors.textPrimary),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: LinearProgressIndicator(
            value: 0.45,
            backgroundColor: Colors.white.withValues(alpha: 0.1),
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryPurple),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Column(
          children: [
            // Start Node
            _buildStartBubble(),
            _buildConnector(isActive: true),
            
            // Section 1: Basics
            _buildSectionHeader('Basics'),
            _buildConnector(isActive: true),
            
            _buildTopicNode(context, 'Variables', 'completed'),
            _buildConnector(isActive: true),
            
            _buildTopicNode(context, 'Data Types', 'in-progress'),
            _buildConnector(isActive: false),
            
            _buildTopicNode(context, 'Operators', 'locked'),
            _buildConnector(isActive: false, height: 40),
            
            // Section 2: Control Flow
            _buildSectionHeader('Control Flow', isLocked: true),
            _buildConnector(isActive: false),
            
            _buildTopicNode(context, 'If / Else', 'locked'),
            _buildConnector(isActive: false),
            
            // Loops
            _buildSectionHeader('Loops', isLocked: true),
            _buildConnector(isActive: false),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: _buildTopicNode(context, 'For Loop', 'locked', isBranch: true)),
                const SizedBox(width: 16),
                Expanded(child: _buildTopicNode(context, 'While Loop', 'locked', isBranch: true)),
              ],
            ),
            
            _buildConnector(isActive: false, height: 40),
            _buildSectionHeader('Functions', isLocked: true),
            _buildConnector(isActive: false),
            _buildTopicNode(context, 'Defining & Calling', 'locked'),
            
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildStartBubble() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primaryPurple.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.primaryPurple, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPurple.withValues(alpha: 0.4),
            blurRadius: 15,
            spreadRadius: 2,
          )
        ],
      ),
      child: const Text(
        'START',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.5),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {bool isLocked = false}) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        color: isLocked ? AppColors.textSecondary.withValues(alpha: 0.5) : AppColors.textSecondary,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
        fontSize: 14,
      ),
    );
  }

  Widget _buildConnector({required bool isActive, double height = 30}) {
    return Container(
      width: 4,
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryPurple : Colors.white.withValues(alpha: 0.1),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: AppColors.primaryPurple.withValues(alpha: 0.5),
                  blurRadius: 10,
                  spreadRadius: 1,
                )
              ]
            : null,
      ),
    );
  }

  Widget _buildTopicNode(BuildContext context, String title, String status, {bool isBranch = false}) {
    Color borderColor;
    Color iconColor;
    IconData icon;
    bool hasGlow = false;
    double opacity = 1.0;

    switch (status) {
      case 'completed':
        borderColor = AppColors.accentGreen;
        iconColor = AppColors.accentGreen;
        icon = LucideIcons.checkCircle2;
        hasGlow = true;
        break;
      case 'in-progress':
        borderColor = AppColors.primaryPurple;
        iconColor = AppColors.primaryPurple;
        icon = LucideIcons.playCircle;
        hasGlow = true;
        break;
      case 'locked':
      default:
        borderColor = Colors.white.withValues(alpha: 0.1);
        iconColor = AppColors.textSecondary;
        icon = LucideIcons.lock;
        opacity = 0.5;
        break;
    }

    return GestureDetector(
      onTap: status != 'locked' ? () => _navigateToTopic(context) : null,
      child: Opacity(
        opacity: opacity,
        child: GlassContainer(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: isBranch ? 12 : 16),
          width: isBranch ? null : 240,
          borderColor: borderColor,
          hasGlow: hasGlow,
          glowColor: borderColor,
          borderRadius: 20,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
