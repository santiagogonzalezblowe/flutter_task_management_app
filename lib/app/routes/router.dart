import 'package:flutter_to_do/pages/completed_tasks/completed_tasks_page.dart';
import 'package:flutter_to_do/pages/create_task/create_task_page.dart';
import 'package:flutter_to_do/pages/home/home_page.dart';
import 'package:flutter_to_do/pages/productivity/productivity_page.dart';
import 'package:flutter_to_do/pages/tasks/tasks_page.dart';
import 'package:go_router/go_router.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const HomePage();
      },
      routes: [
        GoRoute(
          path: 'createTask',
          builder: (context, state) {
            return const CreateTaskPage();
          },
        ),
        GoRoute(
          path: 'completedTasks',
          builder: (context, state) {
            return const CompletedTasksPage();
          },
        ),
        GoRoute(
          path: 'tasks',
          builder: (context, state) {
            return const TasksPage();
          },
        ),
        GoRoute(
          path: 'productivity',
          builder: (context, state) {
            return const ProductivityPage();
          },
        )
      ],
    ),
  ],
);
