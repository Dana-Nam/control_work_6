import 'package:flutter/material.dart';
import 'screens/tasks_screen.dart';
import 'screens/task_create_screen.dart';
import 'providers/task_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return TaskState(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => TasksScreen(),
          '/create': (context) => TaskCreateScreen(),
        },
      ),
    );
  }
}
