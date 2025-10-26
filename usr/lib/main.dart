import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FF Logo Maker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LogoMakerScreen(),
    );
  }
}

class LogoMakerScreen extends StatefulWidget {
  const LogoMakerScreen({super.key});

  @override
  State<LogoMakerScreen> createState() => _LogoMakerScreenState();
}

class _LogoMakerScreenState extends State<LogoMakerScreen> {
  // State variables for logo properties
  Color _backgroundColor = Colors.white;
  Color _textColor = Colors.black;
  double _fontSize = 80.0;
  String _fontFamily = 'Roboto';
  String _logoText = 'FF';
  final TextEditingController _textController = TextEditingController(text: 'FF');

  final List<Color> _colorPalette = [
    Colors.black,
    Colors.white,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.teal,
  ];

  final List<String> _fontFamilies = [
    'Roboto',
    'Arial',
    'Times New Roman',
    'Courier',
    'Georgia',
    'Verdana',
  ];

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {
        _logoText = _textController.text;
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FF Logo Maker'),
        elevation: 4.0,
      ),
      body: Column(
        children: [
          // Logo Preview Area
          Expanded(
            flex: 3,
            child: Container(
              color: _backgroundColor,
              child: Center(
                child: Text(
                  _logoText,
                  style: TextStyle(
                    color: _textColor,
                    fontSize: _fontSize,
                    fontFamily: _fontFamily,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          // Controls Area
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.grey[200],
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text Input
                    Text('Logo Text', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your text',
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Font Size Slider
                    Text('Font Size: ${_fontSize.toInt()}', style: Theme.of(context).textTheme.titleMedium),
                    Slider(
                      value: _fontSize,
                      min: 20.0,
                      max: 200.0,
                      divisions: 180,
                      label: _fontSize.round().toString(),
                      onChanged: (value) {
                        setState(() {
                          _fontSize = value;
                        });
                      },
                    ),

                    // Font Family Dropdown
                    Text('Font Style', style: Theme.of(context).textTheme.titleMedium),
                    DropdownButton<String>(
                      value: _fontFamily,
                      isExpanded: true,
                      items: _fontFamilies.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: TextStyle(fontFamily: value)),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _fontFamily = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),

                    // Background Color Picker
                    Text('Background Color', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    _buildColorPicker((color) {
                      setState(() {
                        _backgroundColor = color;
                      });
                    }, _backgroundColor),

                    const SizedBox(height: 16),

                    // Text Color Picker
                    Text('Text Color', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    _buildColorPicker((color) {
                      setState(() {
                        _textColor = color;
                      });
                    }, _textColor),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorPicker(ValueChanged<Color> onColorSelected, Color selectedColor) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _colorPalette.length,
        itemBuilder: (context, index) {
          final color = _colorPalette[index];
          return GestureDetector(
            onTap: () => onColorSelected(color),
            child: Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black.withOpacity(0.5),
                  width: 1,
                ),
                boxShadow: [
                  if (color == selectedColor)
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 2,
                    )
                ],
              ),
              child: color == selectedColor
                  ? const Icon(Icons.check, color: Colors.white)
                  : null,
            ),
          );
        },
      ),
    );
  }
}
