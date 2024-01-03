import 'package:flutter_to_do/app/interface/task_category/task_category.dart';
import 'package:flutter_to_do/app/interface/task_status/task_status.dart';

class TaskModel {
  TaskModel({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.category,
    required this.status,
  });

  final String id;
  final String title;
  final DateTime dateTime;
  final TaskCategory category;
  final TaskStatus status;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json['id'] as String,
        title: json['title'] as String,
        dateTime: DateTime.parse(json['dateTime'] as String),
        category: TaskCategory.values.firstWhere(
          (e) => e.name == json['category'],
        ),
        status: TaskStatus.values.firstWhere(
          (e) => e.name == json['status'],
        ),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'dateTime': dateTime.toIso8601String(),
        'category': category.name,
        'status': status.name,
      };
}
