// lib/services/api_service.dart

import 'package:dio/dio.dart';
import 'package:resource_hub/models/resource.dart';
import 'package:resource_hub/models/search_result.dart';
import '../models/course.dart';
import '../models/module.dart';
import '../models/topic.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl:
          //  'http://10.0.2.2/resourcehub/api/',
          'http://127.0.0.1/resourcehub/api/',
    ),
  );

  // Fetch Courses
  Future<List<Course>> getCourses() async {
    try {
      final response = await _dio.get('get_courses.php');
      if (response.statusCode == 200 && response.data is List) {
        // print(response);
        return (response.data as List)
            .map((json) => Course.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      throw Exception('Failed to load courses: $e');
    }
  }

  Future<List<Resource>> getResources(int topicId) async {
    try {
      final response = await _dio
          .get('get_resources.php', queryParameters: {'topic_id': topicId});
      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List)
            .map((json) => Resource.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load resources');
      }
    } catch (e) {
      throw Exception('Failed to load resources: $e');
    }
  }

  // Fetch Modules by Course ID
  Future<List<Module>> getModules(int courseId) async {
    try {
      final response = await _dio.get(
        'get_modules.php',
        queryParameters: {'course_id': courseId},
      );
      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List)
            .map((json) => Module.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load modules');
      }
    } catch (e) {
      throw Exception('Failed to load modules: $e');
    }
  }

  // Fetch Topics by Module ID
  Future<List<Topic>> getTopics(int moduleId) async {
    try {
      final response = await _dio
          .get('get_topics.php', queryParameters: {'module_id': moduleId});
      // print(response.data); // Print raw response data
      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List)
            .map((json) => Topic.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load topics');
      }
    } catch (e) {
      throw Exception('Failed to load topics: $e');
    }
  }

  // Search Topics and Module Globally

  Future<List<SearchResult>> searchTopics(String searchTerm) async {
    try {
      final response = await _dio.get(
        'search_all_topics.php',
        queryParameters: {'search_term': searchTerm},
      );
      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List)
            .map((json) => SearchResult.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to search topics');
      }
    } catch (e) {
      throw Exception('Failed to search topics: $e');
    }
  }
}
