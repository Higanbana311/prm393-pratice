// Exercise 5 – Debug & Fix Common UI Errors
// Demonstrates 4 common mistakes and their corrected versions side by side.
import 'package:flutter/material.dart';

class DebugFixDemo extends StatefulWidget {
  const DebugFixDemo({super.key});

  @override
  State<DebugFixDemo> createState() => _DebugFixDemoState();
}

class _DebugFixDemoState extends State<DebugFixDemo> {
  // Fix 3: counter that uses setState correctly
  int _counter = 0;

  // Fix 4: selected date for DatePicker
  DateTime? _pickedDate;

  Future<void> _showDatePicker() async {
    // Fix 4: call showDatePicker using BuildContext from a valid widget tree
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null && mounted) {
      setState(() => _pickedDate = date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 5 – Debug & Fix'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----------------------------------------------------------------
            // FIX 1: ListView inside Column → use Expanded
            // ----------------------------------------------------------------
            _SectionHeader(
              number: 1,
              title: 'ListView inside Column',
              fix: 'Wrap ListView with Expanded to give it a bounded height.',
            ),
            // ❌ WRONG (commented out – would throw RenderFlex overflow):
            // Column(children: [ListView(...)])  // unbounded height error

            // ✅ FIXED: ListView wrapped in Expanded inside Column
            SizedBox(
              height: 150,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: const [
                        ListTile(title: Text('List item 1')),
                        ListTile(title: Text('List item 2')),
                        ListTile(title: Text('List item 3')),
                        ListTile(title: Text('List item 4')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ----------------------------------------------------------------
            // FIX 2: Overflow on small screens → SingleChildScrollView
            // ----------------------------------------------------------------
            _SectionHeader(
              number: 2,
              title: 'Overflow on small screens',
              fix: 'Wrap Column body with SingleChildScrollView.',
            ),
            // ✅ Already applied globally – this entire screen uses
            // SingleChildScrollView as the body. Snippet for illustration:
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'body: SingleChildScrollView(\n'
                '  child: Column(children: [ ... ]),\n'
                ')',
                style: TextStyle(fontFamily: 'monospace', fontSize: 13),
              ),
            ),
            const SizedBox(height: 16),

            // ----------------------------------------------------------------
            // FIX 3: Missing setState() on counter
            // ----------------------------------------------------------------
            _SectionHeader(
              number: 3,
              title: 'State update without setState()',
              fix: 'Always call setState() so Flutter rebuilds the widget.',
            ),
            Row(
              children: [
                ElevatedButton(
                  // ✅ FIXED: wrapped in setState
                  onPressed: () => setState(() => _counter++),
                  child: const Text('Increment'),
                ),
                const SizedBox(width: 16),
                Text(
                  'Count: $_counter',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // ----------------------------------------------------------------
            // FIX 4: DatePicker BuildContext error
            // ----------------------------------------------------------------
            _SectionHeader(
              number: 4,
              title: 'DatePicker BuildContext error',
              fix:
                  'Call showDatePicker() from within the widget tree (not in initState or static methods).',
            ),
            ElevatedButton.icon(
              // ✅ FIXED: _showDatePicker is an instance method using this.context
              onPressed: _showDatePicker,
              icon: const Icon(Icons.calendar_month),
              label: const Text('Open DatePicker'),
            ),
            const SizedBox(height: 8),
            Text(
              _pickedDate == null
                  ? 'No date picked yet'
                  : 'Picked: ${_pickedDate!.day}/${_pickedDate!.month}/${_pickedDate!.year}',
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final int number;
  final String title;
  final String fix;

  const _SectionHeader({
    required this.number,
    required this.title,
    required this.fix,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: Colors.deepPurple,
                child: Text('$number',
                    style: const TextStyle(color: Colors.white, fontSize: 13)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '✅ Fix: $fix',
            style: TextStyle(fontSize: 13, color: Colors.green.shade700),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
