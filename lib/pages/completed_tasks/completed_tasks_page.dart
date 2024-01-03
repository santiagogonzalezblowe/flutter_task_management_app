import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do/app/interface/task_status/task_status.dart';
import 'package:flutter_to_do/blocs/tasks/tasks_bloc.dart';
import 'package:flutter_to_do/models/task_model.dart';
import 'package:flutter_to_do/widgets/completed_tasks/completed_tasks_background.dart';
import 'package:flutter_to_do/widgets/completed_tasks/custom_search_bar.dart';
import 'package:flutter_to_do/widgets/global/list_tile_task.dart';

class CompletedTasksPage extends StatefulWidget {
  const CompletedTasksPage({super.key});

  @override
  State<CompletedTasksPage> createState() => _CompletedTasksPageState();
}

class _CompletedTasksPageState extends State<CompletedTasksPage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff6a42d2),
      body: CompletedTasksBackground(
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
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    CustomSearchBar(searchController: searchController),
                    BlocBuilder<TasksBloc, List<TaskModel>>(
                      builder: (context, state) {
                        final searchText = searchController.text.toLowerCase();

                        final completedTasks = state
                            .where((task) =>
                                task.status == TaskStatus.completed &&
                                task.title.toLowerCase().contains(searchText))
                            .toList();

                        return Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            itemCount: completedTasks.length,
                            itemBuilder: (context, index) {
                              final task = completedTasks[index];
                              return ListTileTask(
                                key: ValueKey(task.id),
                                task: task,
                                onTaskCompleted: () {},
                                onTaskIncompleted: () {
                                  context
                                      .read<TasksBloc>()
                                      .add(IncompleteTask(task));
                                },
                              );
                            },
                          ),
                        );
                      },
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
