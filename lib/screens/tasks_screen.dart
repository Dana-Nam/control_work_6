import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../providers/task_provider.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildTaskList(List<Task> tasks, {required bool isDone}) {
    final provider = TaskProvider.of(context)!;

    if (tasks.isEmpty) {
      return Center(child: Text('Нет задач'));
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Card(
          margin: EdgeInsets.only(bottom: 16),
          child: ListTile(
            title: Text(task.activity),
            subtitle: Text(task.type),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!isDone)
                  IconButton(
                    icon: Icon(Icons.check, color: Colors.green),
                    onPressed: () {
                      provider.complete(task.key);
                      setState(() {});
                    },
                  ),
                IconButton(
                  icon: Icon(isDone ? Icons.delete : Icons.close,
                      color: Colors.red),
                  onPressed: () {
                    provider.remove(task.key);
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
