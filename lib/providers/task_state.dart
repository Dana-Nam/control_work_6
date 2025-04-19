import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';
import 'task_provider.dart';

class TaskState extends StatefulWidget {
  final Widget child;

  const TaskState({super.key, required this.child});

  @override
  State<TaskState> createState() => _TaskStateState();
}

class _TaskStateState extends State<TaskState> {
  List<Task> tasks = [];
  int points = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final storedTasks = prefs.getStringList('tasks') ?? [];
    final storedPoints = prefs.getInt('points') ?? 0;
    final parsed =
        storedTasks.map((e) => Task.fromJson(jsonDecode(e))).toList();
    setState(() {
      tasks = parsed;
      points = storedPoints;
    });
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = tasks.map((t) => jsonEncode(t.toJson())).toList();
    await prefs.setStringList('tasks', encoded);
    await prefs.setInt('points', points);
  }

  void add(Task task) {
    setState(() {
      tasks.add(task);
    });
    saveData();
  }

  void complete(String key) {
    final index = tasks.indexWhere((t) => t.key == key);
    if (index != -1) {
      setState(() {
        tasks[index] = tasks[index].copyWith(isDone: true);
        points += 1;
      });
      saveData();
    }
  }

  void remove(String key) {
    setState(() {
      tasks.removeWhere((t) => t.key == key);
    });
    saveData();
  }

  @override
  Widget build(BuildContext context) {
    return TaskProvider(
      tasks: tasks,
      add: add,
      complete: complete,
      remove: remove,
      points: points,
      child: widget.child,
    );
  }
}
