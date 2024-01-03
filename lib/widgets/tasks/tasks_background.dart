import 'package:flutter/material.dart';

class TasksBackground extends StatelessWidget {
  const TasksBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 0,
          child: Container(
            height: 80,
            width: 160,
            decoration: const BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
              ),
            ),
          ),
        ),
        Positioned(
          top: 130,
          right: 100,
          child: Container(
            height: 40,
            width: 120,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        const Positioned(
          top: 50,
          left: 10,
          child: Row(
            children: [
              BackButton(
                color: Colors.white,
              ),
              Text(
                'Tasks',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              )
            ],
          ),
        ),
        child,
      ],
    );
  }
}
