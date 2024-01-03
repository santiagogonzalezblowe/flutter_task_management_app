part of 'tasks_bloc.dart';

sealed class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class CreateTask extends TasksEvent {
  final TaskModel taskModel;

  const CreateTask(this.taskModel);
}

class CompleteTask extends TasksEvent {
  final TaskModel taskModel;

  const CompleteTask(this.taskModel);
}

class IncompleteTask extends TasksEvent {
  final TaskModel taskModel;

  const IncompleteTask(this.taskModel);
}
