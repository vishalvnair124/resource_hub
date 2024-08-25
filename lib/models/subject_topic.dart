class SubjectTopic {
  final String id;
  final String name;

  SubjectTopic({
    required this.id,
    required this.name,
  });

  factory SubjectTopic.fromJson(Map<String, dynamic> json) {
    return SubjectTopic(
      id: json['topic_id'],
      name: json['topic_name'],
    );
  }
}
