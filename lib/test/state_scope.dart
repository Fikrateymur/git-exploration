import 'package:flutter/material.dart';

class StateScope extends InheritedWidget {
  const StateScope({
    super.key,
    required super.child,
    required this.color,
    required this.value,
  });

  final int value;
  final Color color;

  static StateScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StateScope>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

class StateScopeWidget extends StatefulWidget {
  const StateScopeWidget({super.key, required this.child});

  final Widget child;

  @override
  State<StateScopeWidget> createState() => StateScopeWidgetState();
}

class StateScopeWidgetState extends State<StateScopeWidget> {
  int _currentIndex = 0;
  int value = 0;
  final _colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
  ];

  void changeColor() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _colors.length;
    });
  }

  void increaseNumber() {
    setState(() {
      value++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StateScope(
        color: _colors[_currentIndex], value: value, child: widget.child);
  }
}
