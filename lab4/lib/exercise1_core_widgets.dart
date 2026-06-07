// Exercise 1 – Core Widgets: Text, Image, Icon, Card, ListTile
import 'package:flutter/material.dart';

class CoreWidgetsDemo extends StatelessWidget {
  const CoreWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 1 – Core Widgets'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Text widget ---
            Text(
              'Flutter Core Widgets',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            const Text(
              'This screen demonstrates the essential Flutter display widgets.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // --- Icon widget ---
            Row(
              children: const [
                Icon(Icons.star, color: Colors.amber, size: 32),
                SizedBox(width: 8),
                Icon(Icons.favorite, color: Colors.red, size: 32),
                SizedBox(width: 8),
                Icon(Icons.flutter_dash, color: Colors.blue, size: 32),
              ],
            ),
            const SizedBox(height: 16),

            // --- Image.network widget ---
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://picsum.photos/seed/flutter/600/200',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context2, err, st) => Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: const Center(child: Icon(Icons.broken_image, size: 48)),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // --- Card + ListTile widget ---
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: Text('John Doe'),
                subtitle: Text('Flutter Developer'),
                trailing: Icon(Icons.more_vert),
              ),
            ),
            const SizedBox(height: 8),

            // Second Card example
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.teal,
                  child: Icon(Icons.code, color: Colors.white),
                ),
                title: Text('Jane Smith'),
                subtitle: Text('UI/UX Designer'),
                trailing: Icon(Icons.more_vert),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
