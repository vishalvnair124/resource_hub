class SubjectTopic {
  final int id;
  final String name;

  SubjectTopic({
    required this.id,
    required this.name,
  });

  factory SubjectTopic.fromJson(Map<String, dynamic> json) {
    return SubjectTopic(
      id: int.tryParse(json['topic_id'].toString()) ?? 0,
      name: json['topic_name'],
    );
  }
}
