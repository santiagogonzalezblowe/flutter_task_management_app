import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do/blocs/tasks/tasks_bloc.dart';
import 'package:flutter_to_do/models/task_model.dart';
import 'package:flutter_to_do/widgets/productivity/productivity_background.dart';
import 'package:flutter_to_do/widgets/productivity/week_tasks_chart.dart';

class ProductivityPage extends StatelessWidget {
  const ProductivityPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff141725),
      body: ProductivityBackground(
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
                    BlocBuilder<TasksBloc, List<TaskModel>>(
                      builder: (context, state) {
                        return WeekTasksChart(
                          tasks: state,
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
