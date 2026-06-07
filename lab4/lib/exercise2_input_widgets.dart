// Exercise 2 – Input Widgets: Slider, Switch, RadioListTile, DatePicker
import 'package:flutter/material.dart';

class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});

  @override
  State<InputControlsDemo> createState() => _InputControlsDemoState();
}

class _InputControlsDemoState extends State<InputControlsDemo> {
  // Slider state
  double _sliderValue = 50;

  // Switch state
  bool _switchValue = false;

  // Radio state
  String _selectedOption = 'Option A';

  // DatePicker state
  DateTime? _selectedDate;

  // Show DatePicker dialog
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 2 – Input Widgets'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Slider ---
            Text('Slider', style: Theme.of(context).textTheme.titleMedium),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: _sliderValue,
                    min: 0,
                    max: 100,
                    divisions: 20,
                    label: _sliderValue.round().toString(),
                    onChanged: (val) => setState(() => _sliderValue = val),
                  ),
                ),
                SizedBox(
                  width: 48,
                  child: Text(
                    _sliderValue.round().toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),

            // --- Switch ---
            Text('Switch', style: Theme.of(context).textTheme.titleMedium),
            SwitchListTile(
              title: Text(_switchValue ? 'Notifications ON' : 'Notifications OFF'),
              value: _switchValue,
              onChanged: (val) => setState(() => _switchValue = val),
            ),
            const Divider(height: 24),

            // --- RadioListTile group (Flutter 3.32+: use RadioGroup) ---
            Text('Radio Buttons', style: Theme.of(context).textTheme.titleMedium),
            RadioGroup<String>(
              groupValue: _selectedOption,
              onChanged: (val) => setState(() => _selectedOption = val!),
              child: Column(
                children: [
                  for (final option in ['Option A', 'Option B', 'Option C'])
                    RadioListTile<String>(
                      title: Text(option),
                      value: option,
                    ),
                ],
              ),
            ),
            const Divider(height: 24),

            // --- DatePicker ---
            Text('Date Picker', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.calendar_today),
              label: const Text('Pick a Date'),
            ),
            const SizedBox(height: 8),
            Text(
              _selectedDate == null
                  ? 'No date selected'
                  : 'Selected: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
              style: const TextStyle(fontSize: 16),
            ),
            const Divider(height: 24),

            // --- Summary of current values ---
            Text('Current Values', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Slider: ${_sliderValue.round()}'),
                  Text('Switch: ${_switchValue ? "ON" : "OFF"}'),
                  Text('Radio: $_selectedOption'),
                  Text(
                    'Date: ${_selectedDate == null ? "not set" : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"}',
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
