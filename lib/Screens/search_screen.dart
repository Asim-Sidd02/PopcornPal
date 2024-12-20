import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List movies = [];
  bool isLoading = false;

  // Function to fetch movies from the API based on search input
  Future<void> fetchMovies(String query) async {
    if (query.isEmpty) return;

    setState(() {
      isLoading = true;
    });

    final url = Uri.parse("https://api.tvmaze.com/search/shows?q=$query");
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          movies = List<Map<String, dynamic>>.from(
              json.decode(response.body).map((item) => item['show']));
        });
      }
    } catch (e) {
      print("Error fetching movies: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextField(
          controller: searchController,
          onSubmitted: (value) => fetchMovies(value),
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Search for movies...",
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => fetchMovies(searchController.text),
            icon: Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(
          child: CircularProgressIndicator(color: Colors.red),
        )
            : movies.isEmpty
            ? Center(
          child: Text(
            "No movies found. Try searching!",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        )
            : GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.7,
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            final String title = movie['name'] ?? "No Title";
            final String imageUrl = movie['image']?['medium'] ??
                "https://via.placeholder.com/210x295";

            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/details',
                  arguments: movie,
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Movie Poster
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  // Movie Title
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
