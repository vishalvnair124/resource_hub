import 'package:flutter/material.dart';
import 'package:resource_hub/routes/fade_transition_route.dart';
import 'package:resource_hub/screens/module_list_screen.dart';
import 'package:resource_hub/screens/search_screen.dart'; // Import SearchScreen
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../models/course.dart';
import '../services/api_service.dart';

class CourseListScreen extends StatefulWidget {
  @override
  _CourseListScreenState createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Course>> _coursesFuture;

  @override
  void initState() {
    super.initState();
    _coursesFuture = _apiService.getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ResourceHUB',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Course>>(
        future: _coursesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No courses found'));
          } else {
            final courses = snapshot.data!;
            final Map<String, List<Course>> coursesBySem = {};

            // Group courses by semester
            for (var course in courses) {
              if (!coursesBySem.containsKey(course.semester)) {
                coursesBySem[course.semester] = [];
              }
              coursesBySem[course.semester]!.add(course);
            }

            return ListView.builder(
              itemCount: coursesBySem.keys.length,
              itemBuilder: (context, semIndex) {
                final semester = coursesBySem.keys.elementAt(semIndex);
                final semesterCourses = coursesBySem[semester]!;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Semester $semester',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: semesterCourses.length,
                        itemBuilder: (context, index) {
                          final course = semesterCourses[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  FadeTransitionRoute(
                                    page: ModuleListScreen(courseId: course.id),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      course.linkImage,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.275,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        color: const Color.fromARGB(
                                            255, 33, 149, 243),
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(50),
                                          bottomRight: Radius.circular(50),
                                        ),
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.12,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 30),
                                              child: Text(
                                                course.name,
                                                style: const TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15, top: 6, bottom: 6),
                                            child: SizedBox(
                                              width: 100,
                                              height: 100,
                                              child: SfRadialGauge(
                                                axes: [
                                                  RadialAxis(
                                                    startAngle: 270,
                                                    endAngle: 270,
                                                    showLabels: false,
                                                    showTicks: false,
                                                    pointers: const [
                                                      RangePointer(
                                                        color: Color.fromARGB(
                                                            255, 5, 225, 241),
                                                        value: 75,
                                                      ),
                                                    ],
                                                    annotations: const [
                                                      GaugeAnnotation(
                                                        widget: Text(
                                                          "100%",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
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
