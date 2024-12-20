import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the movie details from the arguments
    final movie = ModalRoute.of(context)?.settings.arguments as Map;

    // Extract details safely
    final String title = movie['name'] ?? "No Title";
    final String imageUrl = movie['image']?['original'] ??
        "https://via.placeholder.com/300x450";
    final String summary = movie['summary']?.replaceAll(RegExp(r"<[^>]*>"), "") ??
        "No summary available.";
    final String language = movie['language'] ?? "Unknown";
    final String status = movie['status'] ?? "Unknown";
    final String premiered = movie['premiered'] ?? "Unknown";
    final List genres = movie['genres'] ?? [];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie Poster
            Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Genres
                  Text(
                    genres.isNotEmpty
                        ? "Genres: ${genres.join(", ")}"
                        : "Genres: Not Available",
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Metadata
                  Row(
                    children: [
                      MetadataChip(label: language, icon: Icons.language),
                      const SizedBox(width: 8),
                      MetadataChip(label: status, icon: Icons.movie),
                      SizedBox(width: 8),
                      MetadataChip(label: premiered, icon: Icons.calendar_today),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Summary Title
                  const Text(
                    "Summary",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Summary Text
                  Text(
                    summary,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Watch Now Button
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        // Add watch functionality here
                      },
                      child: Text(
                        "Watch Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Metadata Chip Widget
class MetadataChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const MetadataChip({
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Colors.grey[800],
      label: Row(
        children: [
          Icon(icon, color: Colors.white, size: 16),
          SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
