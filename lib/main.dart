import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TemperatureConverter(),
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  final TextEditingController _controller = TextEditingController();
  String _conversion = 'F to C';
  String _result = '';
  List<String> _history = [];

  void _convertTemperature() {
    double input = double.parse(_controller.text);
    double converted;
    if (_conversion == 'F to C') {
      converted = (input - 32) * 5 / 9;
    } else {
      converted = input * 9 / 5 + 32;
    }
    setState(() {
      _result = converted.toStringAsFixed(2);
      _history.insert(0, '$_conversion: $input => $_result');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Fahrenheit to Celsius'),
                    leading: Radio<String>(
                      value: 'F to C',
                      groupValue: _conversion,
                      onChanged: (String? value) {
                        setState(() {
                          _conversion = value!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Celsius to Fahrenheit'),
                    leading: Radio<String>(
                      value: 'C to F',
                      groupValue: _conversion,
                      onChanged: (String? value) {
                        setState(() {
                          _conversion = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter temperature',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertTemperature,
              child: Text('CONVERT'),
            ),
            SizedBox(height: 20),
            Text(
              'Result: $_result',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_history[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
