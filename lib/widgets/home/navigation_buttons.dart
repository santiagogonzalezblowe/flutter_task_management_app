import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do/app/interface/task_status/task_status.dart';
import 'package:flutter_to_do/blocs/tasks/tasks_bloc.dart';
import 'package:flutter_to_do/models/task_model.dart';
import 'package:flutter_to_do/widgets/home/navigation_button.dart';
import 'package:go_router/go_router.dart';

class NavigationButtons extends StatelessWidget {
  const NavigationButtons({super.key});

  int _tasksCompletedInPeriod(
    List<TaskModel> tasks,
    DateTime start,
    DateTime end,
  ) {
    return tasks
        .where(
          (task) =>
              task.dateTime.isAfter(start) &&
              task.dateTime.isBefore(end) &&
              task.status == TaskStatus.completed,
        )
        .length;
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));

    return BlocBuilder<TasksBloc, List<TaskModel>>(
      builder: (context, state) {
        final incompletedTasks = state
            .where(
              (element) => element.status == TaskStatus.incompleted,
            )
            .toList();

        final completedTasks = state
            .where(
              (element) => element.status == TaskStatus.completed,
            )
            .toList();

        final taskCompletedInThisWeek = _tasksCompletedInPeriod(
          completedTasks,
          startOfWeek,
          now,
        );

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavigationButton(
              color: const Color(0xff6a42d2),
              title: completedTasks.length.toString(),
              subtitle: 'Completed',
              onTap: () {
                context.go('/completedTasks');
              },
            ),
            NavigationButton(
              color: const Color(0xff138db9),
              title: incompletedTasks.length.toString(),
              subtitle: 'Tasks/Day',
              onTap: () {
                context.go('/tasks');
              },
            ),
            NavigationButton(
              color: const Color(0xff1a56cf),
              title: '$taskCompletedInThisWeek',
              subtitle: 'Productivity',
              onTap: () {
                context.go('/productivity');
              },
            ),
          ],
        );
      },
    );
  }
}
