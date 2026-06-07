// Exercise 4 – App Structure with Scaffold, AppBar, FAB & Theme (Dark Mode toggle)
import 'package:flutter/material.dart';

class ScaffoldThemeDemo extends StatefulWidget {
  const ScaffoldThemeDemo({super.key});

  @override
  State<ScaffoldThemeDemo> createState() => _ScaffoldThemeDemoState();
}

class _ScaffoldThemeDemoState extends State<ScaffoldThemeDemo> {
  // Controls light / dark mode
  ThemeMode _themeMode = ThemeMode.light;

  int _itemCount = 3;

  void _addItem() => setState(() => _itemCount++);

  @override
  Widget build(BuildContext context) {
    // Wrap in a local MaterialApp to apply ThemeMode without affecting root app
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Exercise 4 – Scaffold & Theme'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              // Pop from the outer Navigator (Exercise 4 screen was pushed from lab home)
              onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            ),
            actions: [
              // Dark mode toggle button in AppBar
              IconButton(
                tooltip: _themeMode == ThemeMode.dark ? 'Light Mode' : 'Dark Mode',
                icon: Icon(
                  _themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
                ),
                onPressed: () => setState(() {
                  _themeMode =
                      _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
                }),
              ),
            ],
          ),
          // Drawer
          drawer: const Drawer(
            child: Center(child: Text('Navigation Drawer')),
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _itemCount,
            itemBuilder: (context, index) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: const Icon(Icons.check_circle_outline),
                title: Text('Item ${index + 1}'),
                subtitle: Text('Added via FloatingActionButton'),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
            label: const Text('Add Item'),
          ),
        ),
      ),
    );
  }
}
