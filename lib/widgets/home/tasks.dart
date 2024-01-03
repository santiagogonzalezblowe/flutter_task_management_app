import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do/app/interface/task_status/task_status.dart';
import 'package:flutter_to_do/blocs/tasks/tasks_bloc.dart';
import 'package:flutter_to_do/models/task_model.dart';
import 'package:flutter_to_do/widgets/global/list_tile_task.dart';

class Tasks extends StatelessWidget {
  const Tasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, List<TaskModel>>(
      builder: (context, state) {
        final incompletedTasks = state
            .where(
              (element) => element.status == TaskStatus.incompleted,
            )
            .toList();

        return ListView.builder(
          itemCount: incompletedTasks.length,
          itemBuilder: (context, index) {
            final task = incompletedTasks[index];
            return ListTileTask(
              key: ValueKey(task.id),
              onTaskCompleted: () {
                context.read<TasksBloc>().add(CompleteTask(task));
              },
              onTaskIncompleted: () {},
              task: task,
            );
          },
        );
      },
    );
  }
}
