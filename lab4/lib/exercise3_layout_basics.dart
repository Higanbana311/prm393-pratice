// Exercise 3 – Layout Basics: Column, Row, Padding, ListView
import 'package:flutter/material.dart';

class LayoutBasicsDemo extends StatelessWidget {
  const LayoutBasicsDemo({super.key});

  // Sample movie list for ListView.builder
  static const _movies = [
    ('Inception', '2010', Icons.movie),
    ('Interstellar', '2014', Icons.star),
    ('The Dark Knight', '2008', Icons.shield),
    ('Dunkirk', '2017', Icons.military_tech),
    ('Tenet', '2020', Icons.loop),
    ('Oppenheimer', '2023', Icons.science),
    ('The Prestige', '2006', Icons.auto_awesome),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 3 – Layout Basics'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Section: Row with stats (horizontal layout) ---
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatBox(label: 'Movies', value: '${_movies.length}', icon: Icons.movie),
                _StatBox(label: 'Rating', value: '9.0', icon: Icons.star),
                _StatBox(label: 'Genre', value: 'Sci-Fi', icon: Icons.category),
              ],
            ),
          ),

          // --- Section title with padding ---
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Popular Movies',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),

          // --- ListView.builder (must be in Expanded to avoid unbounded height) ---
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                final (title, year, icon) = _movies[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepPurple.shade100,
                        child: Icon(icon, color: Colors.deepPurple),
                      ),
                      title: Text(title),
                      subtitle: Text('Year: $year'),
                      trailing: const Icon(Icons.play_circle_outline),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatBox({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.deepPurple, size: 28),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}
