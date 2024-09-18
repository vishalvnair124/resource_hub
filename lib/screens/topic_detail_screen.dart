import 'package:flutter/material.dart';
import '../models/resource.dart';
import '../services/api_service.dart';

class TopicDetailScreen extends StatefulWidget {
  final int topicId;
  final String topicName;

  TopicDetailScreen({required this.topicId, required this.topicName});

  @override
  _TopicDetailScreenState createState() => _TopicDetailScreenState();
}

class _TopicDetailScreenState extends State<TopicDetailScreen> {
  late Future<List<Resource>> _resourcesFuture;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _resourcesFuture = _apiService.getResources(widget.topicId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.topicName),
      ),
      body: FutureBuilder<List<Resource>>(
        future: _resourcesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No resources found'));
          } else {
            final resources = snapshot.data!;
            // Group resources by type
            final groupedResources = <String, List<Resource>>{};
            for (var resource in resources) {
              if (!groupedResources.containsKey(resource.type)) {
                groupedResources[resource.type] = [];
              }
              groupedResources[resource.type]!.add(resource);
            }

            return ListView(
              children: groupedResources.entries.map((entry) {
                final type = entry.key;
                final resources = entry.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        type.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...resources.map((resource) {
                      if (resource.link.isNotEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(resource.link),
                              onTap: () {
                                // Handle resource tap
                                // You can use a launch function to open URLs
                              },
                            ),
                            const Divider(), // Adds a divider between resources
                          ],
                        );
                      } else {
                        return SizedBox
                            .shrink(); // Handle empty links gracefully
                      }
                    }).toList(),
                  ],
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
