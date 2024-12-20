import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final Map movie;
  final VoidCallback onTap;

  MovieCard({required this.movie, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: movie['image'] != null
            ? Image.network(
          movie['image']['medium'],
          width: 50,
          height: 75,
          fit: BoxFit.cover,
        )
            : null,
        title: Text(movie['name']),
        subtitle: Text(
          movie['summary']?.replaceAll(RegExp(r'<[^>]*>'), '') ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: onTap,
      ),
    );
  }
}
