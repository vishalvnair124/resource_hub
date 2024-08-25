class Module {
  final int id;
  final String name;
  final int courseId;

  Module({
    required this.id,
    required this.name,
    required this.courseId,
  });

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      id: json['module_id'] as int,
      name: json['name'] as String,
      courseId: json['course_id'] as int,
    );
  }
}
