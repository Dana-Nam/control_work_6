import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;

  const TaskDetailScreen({super.key, required this.task});

  String getTypeLabel(String type) {
    final map = {
      'education': 'Образование',
      'recreational': 'Развлечения',
      'social': 'Общение',
      'diy': 'Сделай сам',
      'charity': 'Благотворительность',
      'cooking': 'Готовка',
      'relaxation': 'Отдых',
      'music': 'Музыка',
      'busywork': 'Рутина',
    };
    return map[type] ?? type;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Задача')),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(task.activity,
                textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
            SizedBox(height: 24),
            Text('Категория: ${getTypeLabel(task.type)}',
                style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
