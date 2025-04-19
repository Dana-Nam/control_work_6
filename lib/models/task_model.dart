class Task {
  final String key;
  final String activity;
  final String type;
  final bool isDone;

  Task({
    required this.key,
    required this.activity,
    required this.type,
    this.isDone = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      key: json['key'],
      activity: json['activity'],
      type: json['type'],
      isDone: json['isDone'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'activity': activity,
      'type': type,
      'isDone': isDone,
    };
  }

  Task copyWith({bool? isDone}) {
    return Task(
      key: key,
      activity: activity,
      type: type,
      isDone: isDone ?? this.isDone,
    );
  }
}
