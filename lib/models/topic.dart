// lib/models/topic.dart

class Topic {
  final int topicId;
  final int moduleId;
  final String name;

  Topic({
    required this.topicId,
    required this.moduleId,
    required this.name,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      topicId: int.tryParse(json['topic_id'].toString()) ?? 0,
      moduleId: int.tryParse(json['module_id'].toString()) ?? 0,
      name: json['name'] as String,
    );
  }
}
