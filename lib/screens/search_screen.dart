import 'package:flutter/material.dart';
import 'package:resource_hub/screens/topic_detail_screen.dart';
import '../services/api_service.dart';
import '../models/search_result.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ApiService _apiService = ApiService();
  List<SearchResult> _searchResults = [];
  bool _isLoading = false;
  String _error = '';
  bool _noResultsFound = false;

  void _performSearch() async {
    final searchTerm = _searchController.text.trim();
    if (searchTerm.isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = '';
      _noResultsFound = false;
    });

    try {
      final results = await _apiService.searchTopics(searchTerm);
      setState(() {
        _searchResults = results;
        _noResultsFound = results.isEmpty;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to perform search';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Topics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue), // Border color when not focused
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0), // Border color when focused
                    ),
                    fillColor: Colors.white, // Background fill color
                    filled: true, // Fill the background with color
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(5.0), // Adjust the radius as needed
                  child: MaterialButton(
                    onPressed: _performSearch,
                    minWidth: MediaQuery.of(context).size.width * 0.93,
                    height: MediaQuery.of(context).size.width * 0.125,
                    color: const Color.fromARGB(255, 66, 153, 240),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "SEARCH",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(Icons.search),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16.0),
            _isLoading
                ? const CircularProgressIndicator()
                : _error.isNotEmpty
                    ? Text(_error, style: const TextStyle(color: Colors.red))
                    : _noResultsFound
                        ? const Text(
                            'No results found',
                            style: TextStyle(fontSize: 18),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: _searchResults.length,
                              itemBuilder: (context, index) {
                                final result = _searchResults[index];

                                // Check if the module has only one topic
                                if (result.topics.length == 1) {
                                  final singleTopic = result.topics.first;
                                  return Card(
                                    child: ListTile(
                                      title: Text(singleTopic.name),
                                      subtitle: Text(result.courseName),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TopicDetailScreen(
                                              topicId: singleTopic.id,
                                              topicName: singleTopic.name,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  // Display the module with an ExpansionTile if there are multiple topics
                                  return Card(
                                    child: ExpansionTile(
                                      title: Text(result.moduleName),
                                      subtitle: Text(result.courseName),
                                      children: result.topics.map((topic) {
                                        return ListTile(
                                          title: Text(topic.name),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    TopicDetailScreen(
                                                  topicId: topic.id,
                                                  topicName: topic.name,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  );
                                }
                              },
                            ),
                          )
          ],
        ),
      ),
    );
  }
}
