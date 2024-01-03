import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HeadlineTasks extends StatelessWidget {
  const HeadlineTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Your Tasks',
          style: TextStyle(
            color: Color(0xff535961),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        FloatingActionButton(
          onPressed: () {
            context.go('/createTask');
          },
          backgroundColor: const Color(0xff2dbdd8),
          foregroundColor: Colors.white,
          elevation: 0,
          highlightElevation: 2,
          child: const Icon(
            Icons.add,
          ),
        ),
      ],
    );
  }
}
