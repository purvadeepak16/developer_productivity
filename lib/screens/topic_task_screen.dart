import 'package:flutter/material.dart';
import 'topic_notes_screen.dart';

class TopicTaskScreen extends StatelessWidget {
  final String topicTitle;
  final String language;
  final String level;
  final String notesContent;
  final String audioUrl;
  final String assessmentContent;
  final String logicContent;
  final String aiFetchedContent;

  const TopicTaskScreen({
    Key? key,
    required this.topicTitle,
    required this.language,
    required this.level,
    required this.notesContent,
    required this.audioUrl,
    required this.assessmentContent,
    required this.logicContent,
    required this.aiFetchedContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(topicTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCard(context, 'Notes (Read + Audio)', Icons.menu_book, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TopicNotesScreen(
                    topicTitle: topicTitle,
                    language: language,
                    level: level,
                    notesContent: notesContent,
                    audioUrl: audioUrl,
                    aiFetchedContent: aiFetchedContent,
                  ),
                ),
              );
            }),
            SizedBox(height: 16),
            _buildCard(context, 'Assessment', Icons.assignment, () {
              _showAssessmentDialog(context);
            }),
            SizedBox(height: 16),
            _buildCard(context, 'Logic Building', Icons.extension, () {
              _showLogicDialog(context);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: Icon(icon, size: 32),
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }

  void _showAssessmentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Assessment'),
        content: Text(assessmentContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showLogicDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logic Building'),
        content: Text(logicContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}
