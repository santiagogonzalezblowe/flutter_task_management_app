import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do/app/interface/task_category/task_category.dart';
import 'package:flutter_to_do/app/interface/task_status/task_status.dart';
import 'package:flutter_to_do/blocs/tasks/tasks_bloc.dart';
import 'package:flutter_to_do/models/task_model.dart';
import 'package:flutter_to_do/widgets/create_task/create_new_task_icon.dart';
import 'package:flutter_to_do/widgets/create_task/create_task_background.dart';
import 'package:flutter_to_do/widgets/create_task/task_category_field.dart';
import 'package:flutter_to_do/widgets/create_task/task_date_time_fields.dart';
import 'package:flutter_to_do/widgets/create_task/task_name_field.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final taskNameController = TextEditingController();

  var category = TaskCategory.personal;
  DateTime? date;
  TimeOfDay? time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1a56cf),
      resizeToAvoidBottomInset: false,
      body: CreateTaskBackground(
        child: Column(
          children: [
            const Expanded(
              flex: 5,
              child: CreateNewTaskIcon(),
            ),
            Expanded(
              flex: 8,
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TaskNameField(
                      controller: taskNameController,
                    ),
                    TaskDateTimeFields(
                      time: time,
                      date: date,
                      onSelectedDate: (newDate) {
                        setState(() {
                          date = newDate;
                        });
                      },
                      onSelectedTime: (newTime) {
                        setState(() {
                          time = newTime;
                        });
                      },
                    ),
                    TaskCategoryField(
                      category: category,
                      onSelected: (newCategory) {
                        setState(() {
                          category = newCategory;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                if (date != null &&
                                    time != null &&
                                    taskNameController.text.isNotEmpty) {
                                  context.read<TasksBloc>().add(
                                        CreateTask(
                                          TaskModel(
                                            id: const Uuid().v4(),
                                            title: taskNameController.text,
                                            dateTime: DateTime(
                                              date!.year,
                                              date!.month,
                                              date!.day,
                                              time!.hour,
                                              time!.minute,
                                            ),
                                            category: category,
                                            status: TaskStatus.incompleted,
                                          ),
                                        ),
                                      );

                                  context.pop();
                                }
                              },
                              icon: const Icon(Icons.add),
                              label: const Text('Add Task'),
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: const Color(0xff2dbdd8),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 20,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                          ),
                        ],
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
