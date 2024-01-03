import 'package:equatable/equatable.dart';
import 'package:flutter_to_do/app/interface/task_status/task_status.dart';
import 'package:flutter_to_do/models/task_model.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'tasks_event.dart';

class TasksBloc extends HydratedBloc<TasksEvent, List<TaskModel>> {
  TasksBloc() : super([]) {
    on<CreateTask>(onCreateTask);
    on<CompleteTask>(onCompleteTask);
    on<IncompleteTask>(onIncompleteTask);
  }

  void onCreateTask(CreateTask event, Emitter<List<TaskModel>> emit) {
    final newList = List<TaskModel>.from(state)..add(event.taskModel);
    emit(newList);
  }

  void onCompleteTask(CompleteTask event, Emitter<List<TaskModel>> emit) {
    final newList = state.map((task) {
      if (task.id == event.taskModel.id) {
        return TaskModel(
          id: task.id,
          title: task.title,
          dateTime: task.dateTime,
          category: task.category,
          status: TaskStatus.completed,
        );
      }
      return task;
    }).toList();

    emit(newList);
  }

  void onIncompleteTask(IncompleteTask event, Emitter<List<TaskModel>> emit) {
    final newList = state.map((task) {
      if (task.id == event.taskModel.id) {
        return TaskModel(
          id: task.id,
          title: task.title,
          dateTime: task.dateTime,
          category: task.category,
          status: TaskStatus.incompleted,
        );
      }
      return task;
    }).toList();

    emit(newList);
  }

  @override
  List<TaskModel>? fromJson(Map<String, dynamic> json) {
    var tasksJson = json['tasks'] as List;
    return tasksJson.map((taskJson) => TaskModel.fromJson(taskJson)).toList();
  }

  @override
  Map<String, dynamic>? toJson(List<TaskModel> state) {
    return {
      'tasks': state.map((task) => task.toJson()).toList(),
    };
  }
}
