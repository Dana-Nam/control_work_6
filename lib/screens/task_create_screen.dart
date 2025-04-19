import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/task_model.dart';
import '../providers/task_provider.dart';
import '../screens/task_detail_screen.dart';

class TaskCreateScreen extends StatefulWidget {
  const TaskCreateScreen({super.key});

  @override
  State<TaskCreateScreen> createState() => _TaskCreateScreenState();
}

class _TaskCreateScreenState extends State<TaskCreateScreen> {
  String selectedType = 'random';

  final Map<String, String> typeLabels = {
    'random': 'Случайная',
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

  Future<void> fetchTask() async {
    String url = 'https://bored.api.lewagon.com/api/activity';
    if (selectedType != 'random') {
      url += '?type=$selectedType';
    }

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final task = Task(
        key: data['key'],
        activity: data['activity'],
        type: data['type'],
      );

      TaskProvider.of(context)?.add(task);

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => TaskDetailScreen(task: task),
        ),
      );

      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Создать задачу')),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedType,
              decoration: InputDecoration(
                hintText: 'Выберите категорию',
                border: OutlineInputBorder(),
              ),
              items: typeLabels.entries.map((entry) {
                return DropdownMenuItem(
                  value: entry.key,
                  child: Text(entry.value),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedType = value;
                  });
                }
              },
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: fetchTask,
              child: Text('Получить задачу'),
            ),
          ],
        ),
      ),
    );
  }
}
