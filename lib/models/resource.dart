// lib/models/resource.dart

class Resource {
  final int resourceId;
  final int topicId;
  final String type;
  final String link;

  Resource({
    required this.resourceId,
    required this.topicId,
    required this.type,
    required this.link,
  });

  factory Resource.fromJson(Map<String, dynamic> json) {
    return Resource(
      resourceId: int.tryParse(json['resource_id'].toString()) ?? 0,
      topicId: int.tryParse(json['topic_id'].toString()) ?? 0,
      type: json['type'] as String,
      link: json['link'] as String,
    );
  }
}
