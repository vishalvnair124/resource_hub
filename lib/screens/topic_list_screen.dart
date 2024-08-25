// lib/screens/topic_list_screen.dart

import 'package:flutter/material.dart';

import 'package:resource_hub/routes/slide_transition_route.dart';
import 'package:resource_hub/screens/topic_detail_screen.dart';
import '../models/topic.dart';
import '../services/api_service.dart';

class TopicListScreen extends StatefulWidget {
  final int moduleId;

  TopicListScreen({required this.moduleId});

  @override
  _TopicListScreenState createState() => _TopicListScreenState();
}

class _TopicListScreenState extends State<TopicListScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Topic>> _topicsFuture;

  @override
  void initState() {
    super.initState();
    _topicsFuture = _apiService.getTopics(widget.moduleId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Topics'),
      ),
      body: FutureBuilder<List<Topic>>(
        future: _topicsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No topics found'));
          } else {
            final topics = snapshot.data!;
            return ListView.builder(
              itemCount: topics.length,
              itemBuilder: (context, index) {
                final topic = topics[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      // Navigating to TopicDetailScreen with slide transition
                      Navigator.of(context).push(
                        SlideTransitionRoute(
                          page: TopicDetailScreen(
                            topicId: topic.topicId,
                            topicName: topic.name,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 118, 183, 237),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        topic.name,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
