import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/glass_container.dart';

/// LevelDetailScreen
///
/// Displays an overview, expandable topics, conceptual map cards and a
/// logical timeline. Receives `levelData` (Map<String, dynamic>) and
/// renders the content with full null-safety. Dark theme styling is used.
class LevelDetailScreen extends StatelessWidget {
  final Map<String, dynamic>? levelData;
  final String? levelTitle;

  const LevelDetailScreen({super.key, this.levelData, this.levelTitle});

  List<dynamic> _safeList(dynamic v) => (v is List) ? v : <dynamic>[];

  Widget _overviewSection(String overview) {
    return GlassContainer(
      borderRadius: 16,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Overview', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 260),
            child: SingleChildScrollView(
              child: Text(overview, style: const TextStyle(color: Colors.white, height: 1.5)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _topicsSection(List<dynamic> topics) {
    if (topics.isEmpty) {
      return GlassContainer(
        borderRadius: 16,
        padding: const EdgeInsets.all(12),
        child: const Text('No topics available', style: TextStyle(color: Colors.white70)),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: topics.map<Widget>((t) {
        final topic = (t is Map) ? t : <String, dynamic>{};
        final title = (topic['title'] ?? '').toString();
        final theory = (topic['theory'] ?? '').toString();
        final keyPoints = _safeList(topic['key_points']);
        final mistakes = _safeList(topic['common_mistakes']);

        return GlassContainer(
          borderRadius: 12,
          padding: const EdgeInsets.all(12),
          child: ExpansionTile(
            tilePadding: EdgeInsets.zero,
            collapsedIconColor: Colors.white,
            iconColor: Colors.white,
            title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            children: [
              if (theory.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                  child: Text(theory, style: const TextStyle(color: Colors.white70)),
                ),
              if (keyPoints.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),
                      const Text('Key points', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      ...keyPoints.map<Widget>((kp) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('• ', style: TextStyle(color: Colors.white)),
                                Expanded(child: Text(kp.toString(), style: const TextStyle(color: Colors.white70))),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              if (mistakes.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Common mistakes', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      ...mistakes.map<Widget>((m) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('• ', style: TextStyle(color: Colors.redAccent)),
                                Expanded(child: Text(m.toString(), style: const TextStyle(color: Colors.redAccent))),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _conceptualSection(List<dynamic> concepts) {
    if (concepts.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: concepts.map<Widget>((c) {
        final m = (c is Map) ? c : <String, dynamic>{};
        final concept = (m['concept'] ?? '').toString();
        final definition = (m['definition'] ?? '').toString();
        final why = (m['why_important'] ?? '').toString();
        final connected = _safeList(m['connected_to']).map((e) => e.toString()).toList();

        return GlassContainer(
          borderRadius: 12,
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(concept, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              if (definition.isNotEmpty) Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(definition, style: const TextStyle(color: Colors.white70)),
              ),
              if (why.isNotEmpty) Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text('Why: $why', style: const TextStyle(color: Colors.white70)),
              ),
              if (connected.isNotEmpty) Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text('Connected to: ${connected.join(', ')}', style: const TextStyle(color: Colors.white70)),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _logicalSection(List<dynamic> steps) {
    if (steps.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: steps.asMap().entries.map<Widget>((entry) {
        final idx = entry.key;
        final s = entry.value is Map ? entry.value as Map<String, dynamic> : <String, dynamic>{};
        final stepNum = (s['step'] ?? (idx + 1)).toString();
        final learn = (s['learn'] ?? '').toString();
        final reason = (s['reason'] ?? '').toString();

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.primaryPurple,
                child: Text(stepNum, style: const TextStyle(color: Colors.white, fontSize: 12)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (learn.isNotEmpty) Text(learn, style: const TextStyle(color: Colors.white)),
                    if (reason.isNotEmpty) Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text('Why: $reason', style: const TextStyle(color: Colors.white70)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = levelData ?? <String, dynamic>{};

    final overview = (data['overview'] ?? data['content'] ?? '').toString();
    final topics = _safeList(data['topics']);
    final conceptual = _safeList(data['conceptual_map']);
    final logical = _safeList(data['logical_map']);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text((levelTitle ?? 'Level').toUpperCase()),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _overviewSection(overview),
              const SizedBox(height: 12),
              Text('Topics', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _topicsSection(topics),
              const SizedBox(height: 12),
              Text('Conceptual Map', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _conceptualSection(conceptual),
              const SizedBox(height: 12),
              Text('Logical Map', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _logicalSection(logical),
            ],
          ),
        ),
      ),
    );
  }
}
