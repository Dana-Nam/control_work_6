import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback? onComplete;
  final VoidCallback? onRemove;

  const TaskCard({
    super.key,
    required this.task,
    this.onComplete,
    this.onRemove,
  });

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
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: Text(task.activity),
        subtitle: Text(getTypeLabel(task.type)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!task.isDone && onComplete != null)
              IconButton(
                icon: Icon(Icons.check, color: Colors.green),
                onPressed: onComplete,
              ),
            if (onRemove != null)
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: onRemove,
              ),
          ],
        ),
      ),
    );
  }
}
