class Course {
  final int id;
  final String name;
  final String linkImage;
  final String semester;

  Course({
    required this.id,
    required this.name,
    required this.linkImage,
    required this.semester,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: int.tryParse(json['course_id'].toString()) ?? 0,
      name: json['name'] as String,
      linkImage: json['course_image'] as String,
      semester: json['course_sem'].toString(),
    );
  }
}
