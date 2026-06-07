import 'package:flutter/material.dart';
import 'exercise1_core_widgets.dart';
import 'exercise2_input_widgets.dart';
import 'exercise3_layout_basics.dart';
import 'exercise4_scaffold_theme.dart';
import 'exercise5_debug_fix.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 4 – Flutter UI Fundamentals',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LabHomeScreen(),
    );
  }
}

class LabHomeScreen extends StatelessWidget {
  const LabHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final exercises = [
      ('Exercise 1', 'Core Widgets', const CoreWidgetsDemo()),
      ('Exercise 2', 'Input Widgets', const InputControlsDemo()),
      ('Exercise 3', 'Layout Basics', const LayoutBasicsDemo()),
      ('Exercise 4', 'Scaffold & Theme', const ScaffoldThemeDemo()),
      ('Exercise 5', 'Debug & Fix', const DebugFixDemo()),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab 4 – Flutter UI Fundamentals'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: exercises.length,
        separatorBuilder: (ctx, i) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final (label, title, screen) = exercises[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text(label),
              subtitle: Text(title),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => screen),
              ),
            ),
          );
        },
      ),
    );
  }
}
