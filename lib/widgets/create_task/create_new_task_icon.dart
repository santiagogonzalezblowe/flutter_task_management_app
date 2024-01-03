import 'package:flutter/material.dart';

class CreateNewTaskIcon extends StatelessWidget {
  const CreateNewTaskIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 36),
        FloatingActionButton(
          onPressed: null,
          shape: CircleBorder(),
          foregroundColor: Color(0xff1a56cf),
          backgroundColor: Colors.white,
          child: Icon(Icons.format_list_bulleted_add),
        ),
        SizedBox(height: 18),
        Text(
          'Create New Task',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
