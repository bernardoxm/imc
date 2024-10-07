import 'package:flutter/material.dart';

class StartButtomWidget extends StatefulWidget {
  const StartButtomWidget({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<StartButtomWidget> createState() => StartButtomWidgetState();
}

class StartButtomWidgetState extends State<StartButtomWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed, 
      child: const Text(
        'Start',
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 100),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
      ),
    );
  }
}
