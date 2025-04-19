import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskProvider extends InheritedWidget {
  final List<Task> tasks;
  final void Function(Task task) add;
  final void Function(String key) complete;
  final void Function(String key) remove;
  final int points;

  const TaskProvider({
    super.key,
    required this.tasks,
    required this.add,
    required this.complete,
    required this.remove,
    required this.points,
    required super.child,
  });

  static TaskProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskProvider>();
  }

  @override
  bool updateShouldNotify(covariant TaskProvider oldWidget) {
    return oldWidget.tasks.length != tasks.length || oldWidget.points != points;
  }
}
