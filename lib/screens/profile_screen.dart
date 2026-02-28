import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Profile Info
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 24), // Spacer for centering avatar
                    Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.primaryPurple, width: 3),
                            image: const DecorationImage(
                              image: NetworkImage('https://i.pravatar.cc/300'),
                            ),
                            boxShadow: [
                              BoxShadow(color: AppColors.primaryPurple.withValues(alpha: 0.5), blurRadius: 20)
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text('Alex_Coder', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primaryPurple.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.primaryPurple.withValues(alpha: 0.5)),
                          ),
                          child: const Text('Level 12 — Code Warrior ⚔️', style: TextStyle(color: AppColors.primaryPurple, fontWeight: FontWeight.bold, fontSize: 12)),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: 200,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('1,200 XP', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                                  Text('2,000 XP', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              LinearProgressIndicator(
                                value: 0.6,
                                backgroundColor: Colors.white.withValues(alpha: 0.1),
                                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryPurple),
                                minHeight: 6,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(LucideIcons.edit2, color: AppColors.textSecondary),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Stats Row
              SizedBox(
                height: 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    _buildStatMiniCard('🔥', '18 Days', 'Streak'),
                    const SizedBox(width: 12),
                    _buildStatMiniCard('⭐', '4,820', 'XP'),
                    const SizedBox(width: 12),
                    _buildStatMiniCard('🏆', '3', 'Certs'),
                    const SizedBox(width: 12),
                    _buildStatMiniCard('📚', '2', 'Langs'),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Languages Section
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text('My Languages', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(child: _buildLanguageProgressCard('Python', 0.82, AppColors.accentGreen, 'Completed ✓')),
                    const SizedBox(width: 16),
                    Expanded(child: _buildLanguageProgressCard('JavaScript', 0.34, AppColors.primaryPurple, 'In Progress')),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Achievement Badges
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text('Achievements', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    _buildBadgeItem(LucideIcons.zap, AppColors.primaryPurple, 'First Login', true),
                    const SizedBox(width: 16),
                    _buildBadgeItem(LucideIcons.flame, AppColors.accentOrange, '7 Day Streak', true),
                    const SizedBox(width: 16),
                    _buildBadgeItem(LucideIcons.puzzle, AppColors.primaryBlue, 'Logic Master', true),
                    const SizedBox(width: 16),
                    _buildBadgeItem(LucideIcons.timer, Colors.grey, 'Speed Coder', false),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Progress Timeline
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text('Activity (Last 30 Days)', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 24),
              GlassContainer(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                height: 200,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: 50,
                      getDrawingHorizontalLine: (value) => FlLine(color: Colors.white.withValues(alpha: 0.05), strokeWidth: 1),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            if (value == 0) return const SizedBox.shrink();
                            return Text('${value.toInt()} XP', style: const TextStyle(color: AppColors.textSecondary, fontSize: 10));
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    minX: 0,
                    maxX: 30,
                    minY: 0,
                    maxY: 200,
                    lineBarsData: [
                      LineChartBarData(
                        spots: const [
                          FlSpot(0, 50),
                          FlSpot(7, 120),
                          FlSpot(14, 80),
                          FlSpot(21, 150),
                          FlSpot(30, 180),
                        ],
                        isCurved: true,
                        color: AppColors.primaryPurple,
                        barWidth: 4,
                        isStrokeCapRound: true,
                        dotData: FlDotData(show: true),
                        belowBarData: BarAreaData(
                          show: true,
                          color: AppColors.primaryPurple.withValues(alpha: 0.2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Bottom List
              _buildListTile(LucideIcons.settings, 'Settings'),
              _buildListTile(LucideIcons.bell, 'Notifications'),
              _buildListTile(LucideIcons.helpCircle, 'Help & Support'),
              _buildListTile(LucideIcons.logOut, 'Log Out', isDanger: true),
              
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatMiniCard(String icon, String value, String label) {
    return GlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildLanguageProgressCard(String title, double progress, Color color, String badgeText) {
    return GlassContainer(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: progress,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  backgroundColor: Colors.white.withValues(alpha: 0.1),
                  strokeWidth: 6,
                ),
                Center(
                  child: Text(
                    '${(progress * 100).toInt()}%',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(badgeText, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeItem(IconData icon, Color color, String title, bool unlocked) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: unlocked ? color.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.05),
            border: Border.all(color: unlocked ? color : Colors.white.withValues(alpha: 0.1), width: 2),
            boxShadow: unlocked ? [BoxShadow(color: color.withValues(alpha: 0.5), blurRadius: 10)] : null,
          ),
          child: Icon(icon, color: unlocked ? color : Colors.white.withValues(alpha: 0.3), size: 28),
        ),
        const SizedBox(height: 8),
        Text(title, style: TextStyle(color: unlocked ? Colors.white : AppColors.textSecondary, fontSize: 12)),
      ],
    );
  }

  Widget _buildListTile(IconData icon, String title, {bool isDanger = false}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
      leading: Icon(icon, color: isDanger ? AppColors.errorRed : AppColors.textSecondary),
      title: Text(
        title,
        style: TextStyle(
          color: isDanger ? AppColors.errorRed : Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: const Icon(LucideIcons.chevronRight, color: AppColors.textSecondary, size: 20),
      onTap: () {},
    );
  }
}
