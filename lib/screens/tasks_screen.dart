import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../providers/task_provider.dart';
import '../widgets/task_card.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final provider = TaskProvider.of(context)!;
    final newTasks = provider.tasks.where((t) => !t.isDone).toList();
    final doneTasks = provider.tasks.where((t) => t.isDone).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Мои задачи'),
        actions: [
          Center(
              child: Text('Баллы: ${provider.points}',
                  style: TextStyle(fontSize: 16))),
          SizedBox(width: 16),
        ],
        bottom: TabBar(
          controller: controller,
          tabs: [
            Tab(text: 'Новые задачи'),
            Tab(text: 'Завершённые'),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [
          buildTaskList(newTasks, isDone: false),
          buildTaskList(doneTasks, isDone: true),
        ],
      ),
      floatingActionButton: newTasks.isNotEmpty
          ? FloatingActionButton(
              onPressed: () async {
                await Navigator.pushNamed(context, '/create');
                if (mounted) setState(() {});
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }

  Widget buildTaskList(List<Task> tasks, {required bool isDone}) {
    final provider = TaskProvider.of(context)!;

    if (tasks.isEmpty && !isDone) {
      return Center(
        child: ElevatedButton(
          onPressed: () async {
            await Navigator.pushNamed(context, '/create');
            if (mounted) setState(() {});
          },
          child: Text('Создать новую задачу'),
        ),
      );
    }

    if (tasks.isEmpty) {
      return Center(child: Text('Нет задач'));
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskCard(
          task: task,
          onComplete: task.isDone
              ? null
              : () {
                  provider.complete(task.key);
                  setState(() {});
                },
          onRemove: () {
            provider.remove(task.key);
            setState(() {});
          },
        );
      },
    );
  }
}
