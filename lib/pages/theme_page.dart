import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({Key? key}) : super(key: key);

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.only(top: 20),
      child: Center(
        child: Consumer<ThemeChangeProvider>(
          builder: (context, value, child) {
            return Column(
              children: [
                AnimatedContainer(
                  // Use the properties stored in the State class.
                  width: value._width,
                  height: value._height,
                  decoration: BoxDecoration(color: value._color),
                  duration: Duration(milliseconds: 500),
                ),
                Switch(
                  value: isChecked,
                  onChanged: (bool value_1) {
                    setState(() {
                      isChecked = value_1;
                      value.getRandomColor();
                      value.getRandomShape();
                    });
                  },
                ),
              ],
            );
          },
        ),
      ),
    ));
  }
}

class ThemeChangeProvider extends ChangeNotifier {
  Random random = Random();
  Color _color = Colors.blue;
  double _width = 100;
  double _height = 100;
  

  void getRandomColor() {
    _color = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    notifyListeners();
  }

  void getRandomShape() {
    _width = random.nextInt(300).toDouble();
    _height = random.nextInt(300).toDouble();
  }
}
