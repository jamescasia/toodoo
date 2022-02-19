class Task {
  final String title;
  final int id;
  final String description;
  bool expanded;
  bool done;

  Task(this.id, this.title, this.description, this.done, this.expanded);
}
