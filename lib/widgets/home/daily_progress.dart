import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do/app/interface/task_status/task_status.dart';
import 'package:flutter_to_do/blocs/tasks/tasks_bloc.dart';
import 'package:flutter_to_do/models/task_model.dart';

class DailyProgress extends StatefulWidget {
  const DailyProgress({super.key});

  @override
  State<DailyProgress> createState() => _DailyProgressState();
}

class _DailyProgressState extends State<DailyProgress> {
  double _progress = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, List<TaskModel>>(
      builder: (context, tasks) {
        final todayTasks = tasks.where((task) {
          return task.dateTime.year == DateTime.now().year &&
              task.dateTime.month == DateTime.now().month &&
              task.dateTime.day == DateTime.now().day;
        }).toList();

        final completedTasksCount = todayTasks
            .where((task) => task.status == TaskStatus.completed)
            .length;

        final newPercentage = (todayTasks.isEmpty)
            ? 0
            : (completedTasksCount / todayTasks.length);

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'DAILY PROGRESS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '${(newPercentage * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(
                begin: _progress,
                end: newPercentage.toDouble(),
              ),
              duration: const Duration(milliseconds: 500),
              builder: (context, value, child) {
                _progress = value;
                return LinearProgressIndicator(
                  value: value,
                  minHeight: 4,
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xff2eb8d3),
                  backgroundColor: const Color(0xff2d3046),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
