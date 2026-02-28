import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_container.dart';

class AiRecommendationScreen extends StatelessWidget {
  const AiRecommendationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(LucideIcons.bot, color: AppColors.primaryPurple, size: 28),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('AI Insights', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text('Personalized for you today', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Alert Card
            GlassContainer(
              padding: const EdgeInsets.all(20),
              hasGlow: true,
              glowColor: AppColors.errorRed.withValues(alpha: 0.5),
              borderColor: AppColors.errorRed.withValues(alpha: 0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(LucideIcons.alertTriangle, color: AppColors.errorRed),
                      SizedBox(width: 12),
                      Text('Weak Areas Detected', style: TextStyle(color: AppColors.errorRed, fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildAlertItem(AppColors.errorRed, 'OOP Logic: 38%'),
                  const SizedBox(height: 8),
                  _buildAlertItem(AppColors.accentOrange, 'File Handling Assessment: 52%'),
                  const SizedBox(height: 8),
                  _buildAlertItem(AppColors.accentOrange, 'Recursion Content: 45%'),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            const Text('Action Plan', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            
            // Revisit Card
            _buildActionCard(
              title: 'Revisit OOP Inheritance',
              subtitle: 'Your logic score is below average threshold. Try 3 new challenges.',
              icon: LucideIcons.brainCircuit,
              accentColor: AppColors.primaryPurple,
              buttonText: 'Practice Now →',
            ),
            const SizedBox(height: 16),
            
            // Re-read Card
            _buildActionCard(
              title: 'Re-read File Handling',
              subtitle: 'You skipped 2 content sections. Complete them to boost score.',
              icon: LucideIcons.bookOpen,
              accentColor: AppColors.primaryBlue,
              buttonText: 'Go to Content →',
            ),
            const SizedBox(height: 16),
            
            // Play Game Card
            _buildActionCard(
              title: 'Play OOP Logic Game',
              subtitle: '3 targeted challenges generated for you by AI.',
              icon: LucideIcons.gamepad2,
              accentColor: AppColors.accentGreen,
              buttonText: 'Start Challenge →',
            ),
            
            const SizedBox(height: 32),
            
            // Today's Study Plan
            GlassContainer(
              padding: const EdgeInsets.all(0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      border: const Border(bottom: BorderSide(color: Colors.white24)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Today\'s AI Study Plan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primaryPurple.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text('~45 mins', style: TextStyle(color: AppColors.primaryPurple, fontSize: 12, fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        _buildChecklistItem('Review OOP concepts', true),
                        _buildChecklistItem('Complete 2 logic puzzles', false),
                        _buildChecklistItem('Read File Handling chapter', false),
                        _buildChecklistItem('Take short assessment', false),
                      ],
                    ),
                  )
                ],
              ),
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertItem(Color color, String text) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 12),
        Text(text, style: const TextStyle(color: Colors.white, fontSize: 14)),
      ],
    );
  }

  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color accentColor,
    required String buttonText,
  }) {
    return GlassContainer(
      padding: const EdgeInsets.all(20),
      hasGlow: true,
      glowColor: accentColor.withValues(alpha: 0.2),
      child: Container(
        decoration: BoxDecoration(
          border: Border(left: BorderSide(color: accentColor, width: 4)),
        ),
        padding: const EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: accentColor, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(subtitle, style: TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.4)),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: accentColor,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                backgroundColor: accentColor.withValues(alpha: 0.1),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(buttonText, style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChecklistItem(String title, bool isChecked) {
    return CheckboxListTile(
      value: isChecked,
      onChanged: (val) {},
      title: Text(
        title,
        style: TextStyle(
          color: isChecked ? AppColors.textSecondary : Colors.white,
          decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: AppColors.primaryPurple,
      checkColor: Colors.white,
      side: const BorderSide(color: AppColors.primaryPurple),
      contentPadding: EdgeInsets.zero,
      dense: true,
    );
  }
}
