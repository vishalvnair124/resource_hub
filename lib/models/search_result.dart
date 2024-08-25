import 'package:resource_hub/models/subject_topic.dart';

class SearchResult {
  final String moduleName;
  final String courseName;
  final List<SubjectTopic> topics;

  SearchResult({
    required this.moduleName,
    required this.courseName,
    required this.topics,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    var topicsJson = json['topics'] as List;
    List<SubjectTopic> topicsList = topicsJson
        .map((topicJson) => SubjectTopic.fromJson(topicJson))
        .toList();

    return SearchResult(
      moduleName: json['module_name'],
      courseName: json['course_name'],
      topics: topicsList,
    );
  }
}
