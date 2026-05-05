import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculatrice',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
      ),
      home: const CalculatriceScreen(),
    );
  }
}

class CalculatriceScreen extends StatefulWidget {
  const CalculatriceScreen({super.key});

  @override
  State<CalculatriceScreen> createState() => _CalculatriceScreenState();
}

class _CalculatriceScreenState extends State<CalculatriceScreen> {
  String _display = '';
  String _result = '';

  void _append(String val) {
    setState(() => _display += val);
  }

  void _clear() {
    setState(() {
      _display = '';
      _result = '';
    });
  }

  void _calculate() {
    try {
      double a, b;
      if (_display.contains('+')) {
        var parts = _display.split('+');
        a = double.parse(parts[0]);
        b = double.parse(parts[1]);
        setState(() => _result = (a + b).toString());
      } else if (_display.contains('-')) {
        var parts = _display.split('-');
        a = double.parse(parts[0]);
        b = double.parse(parts[1]);
        setState(() => _result = (a - b).toString());
      } else if (_display.contains('*')) {
        var parts = _display.split('*');
        a = double.parse(parts[0]);
        b = double.parse(parts[1]);
        setState(() => _result = (a * b).toString());
      } else if (_display.contains('/')) {
        var parts = _display.split('/');
        a = double.parse(parts[0]);
        b = double.parse(parts[1]);
        setState(() => _result = (a / b).toString());
      }
    } catch (e) {
      setState(() => _result = 'Erreur');
    }
  }

  Widget _buildButton(String label, {Color? color, VoidCallback? onTap}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ElevatedButton(
          onPressed: onTap ?? () => _append(label),
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.grey[800],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(label, style: const TextStyle(fontSize: 22)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Calculatrice'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _display,
                    style: const TextStyle(color: Colors.white70, fontSize: 28),
                  ),
                  Text(
                    _result,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildButton('C', color: Colors.red, onTap: _clear),
                    _buildButton('/', color: Colors.orange),
                    _buildButton('*', color: Colors.orange),
                    _buildButton('-', color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('7'),
                    _buildButton('8'),
                    _buildButton('9'),
                    _buildButton('+', color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('4'),
                    _buildButton('5'),
                    _buildButton('6'),
                    _buildButton('=', color: Colors.orange, onTap: _calculate),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('1'),
                    _buildButton('2'),
                    _buildButton('3'),
                    _buildButton('.'),
                  ],
                ),
                Row(children: [_buildButton('0')]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
