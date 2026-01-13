class Lesson {
  final String id;
  final String title;
  final String icon;
  final bool unlocked;
  final int level;
  final double progress;
  final List<LessonStep> steps;

  Lesson({
    required this.id,
    required this.title,
    required this.icon,
    required this.unlocked,
    required this.level,
    required this.progress,
    this.steps = const [],
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id']?.toString() ?? "",
      title: json['title']?.toString() ?? "",
      icon: json['icon']?.toString() ?? "📘",
      unlocked: json['unlocked'] == true,
      level: int.tryParse(json['level']?.toString() ?? "0") ?? 0,
      progress: double.tryParse(json['progress']?.toString() ?? "0") ?? 0.0,
      steps: (json['steps'] as List<dynamic>? ?? [])
          .map((e) => LessonStep.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "icon": icon,
      "unlocked": unlocked,
      "level": level,
      "progress": progress,
      "steps": steps.map((x) => x.toJson()).toList(),
    };
  }

  bool get isCompleted => progress >= 1.0;
  bool get isCurrent => unlocked && progress < 1.0;
}

class LessonStep {
  final String id;
  final LessonStepType type;
  final String content;
  final List<String> options;
  final int? correctIndex;

  LessonStep({
    required this.id,
    required this.type,
    required this.content,
    this.options = const [],
    this.correctIndex,
  });

  factory LessonStep.fromJson(Map<String, dynamic> json) {
    return LessonStep(
      id: json['id']?.toString() ?? "",
      type: LessonStepType
          .values[int.tryParse(json['type']?.toString() ?? "0") ?? 0],
      content: json['content']?.toString() ?? "",
      options: (json['options'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      correctIndex: json['correctIndex'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "type": type.index,
      "content": content,
      "options": options,
      "correctIndex": correctIndex,
    };
  }
}

enum LessonStepType { text, multipleChoice, trueFalse, dragMatch }
