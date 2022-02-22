/* Task is the task object */

class Task {
  final String id;
  final String title;
  final String description;
  bool done;
  bool expanded;

  Task(this.id, this.title, this.description, this.done, this.expanded);

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(json['id'], json['title'], json['description'],
        json['done'] == 'true', json['expanded'] == 'true');
  }
  Map toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'done': done.toString(),
        'expanded': expanded.toString()
      };
}
