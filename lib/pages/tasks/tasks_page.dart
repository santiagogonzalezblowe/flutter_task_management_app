import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do/blocs/tasks/tasks_bloc.dart';
import 'package:flutter_to_do/models/task_model.dart';
import 'package:flutter_to_do/widgets/tasks/completed_tasks_chart.dart';
import 'package:flutter_to_do/widgets/tasks/tasks_background.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff138db9),
      body: TasksBackground(
        child: Column(
          children: [
            const Expanded(
              child: SizedBox(),
            ),
            Expanded(
              flex: 5,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  children: [
                    Expanded(
                      child: BlocBuilder<TasksBloc, List<TaskModel>>(
                        builder: (context, state) {
                          return TasksChart(
                            tasks: state,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
